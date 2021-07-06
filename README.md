# k8s cluster

###### Imagine having a README as if someone would read this

There's a bunch of things in my cluster, and I attempt to keep the disorder in check here:

- Top-level folders match 1:1 with namespaces
- As a general rule, namespaces match to "projects"
- `default` is a bit of a dumping ground of low-importance infra

---

Following are the important bits

## Deploying stuff

### What's this [Helm](https://helm.sh)/[Helmfile](https://github.com/roboll/helmfile) thing?

Helm is to Kubernetes what package managers are to Linux. Premade application deployments who you only tweak the configuration of, rather than writing all the
boilerplate too. A good idea plagued by an implementation that just fucking sucks <sup>1</sup>

Whichever way you (or I) feel about it, using [Helmfile](https://github.com/roboll/helmfile), most of the annoyances of Helm can be worked around, resulting in
a mostly pleasant experience.

### [HAProxy Ingress](https://haproxy-ingress.github.io/) Controller

> insert long rant about how fucking insanely bad every explanation of ingress controllers is...

> I'll write something legible about it sometime

Already a big fan of HAProxy when it comes to load-balancing in general. Proxy-protocol is a massive bonus when running k8s behind another HAProxy balancing to
nodes (although see [MetalLB](#about-metallbhttpsmetallbuniversetf) for why you might not need it).

Works like a charm, is fast and configurable. What else can I ask?

## Pretending like on-premise k8s is as easy as managed k8s

I like burning money as much as the next person, but on hardware rather than on cloud services if I can.

### About [Ceph](https://ceph.io)

So you tell me a bunch of disks can be made to expose a CSI that provisions block, filesystem and S3 storage? All of this with high-performance (unlike NFS) and
strong reliability and redundancy (unlike NFS, again)?

Yup. And it's free. And it's stupid cool. 10/10 look into it.

### About [MetalLB](https://metallb.universe.tf)

What if you didn't have to sacrifice some CPU/RAM to running a HAProxy (no hate on HAProxy tho) that just dumbly balances incoming traffic across your k8s
nodes' ingress controller port?

Well, if you have access to an environment with a router that can speak BGP and do ECMP, suddenly you can offload the balancing to it transparently. Pretty
nifty if you ask me.

## The cluster's manifests are public? Isn't that dangerous?

I mean I wouldn't recommend it if you were running a bank, but in this case it's pretty decently enabled by Vault.

### About [Vault](https://www.vaultproject.io/)

You guessed it, another fantastic piece of technology I'd recommend you look into.

Essentially works like a secrets manager with authorization bindings to Kubernetes Namespace x ServiceAccount combinations. Also a lot more things. Also HA.
Also fast and lightweight.

The whole possibility of keeping this cluster open-source is backed by its [Agent Injector](https://www.vaultproject.io/docs/platform/k8s/injector). It's not
perfect, but it's a massive improvement over pretty much anything else.

---

## Notes

I tend to criticize things too much, but on the other hand I also believe my own stuff is crap. I just tend to have higher expectations for widely adopted tech,
hence these notes. Now, without further ado:

<sup>1</sup> Basically anything in a Helmfile should have been de-facto standard of Helm. The fact that multiple commands and CLI flags to manage releases is "
the way" is frankly awful, at best. 