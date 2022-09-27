# MozAloha WebGPU Lightning Talk
## Script

### Slide 1

Hi! I'm Jim Blandy, tech lead for Firefox's implementation of the WebGPU graphics API.

WebGPU is a new toolset, still in development, that will let web
developers take more advantage of the amazing graphics processors that
are present in every laptop, tablet, and phone today. WebGPU aims to
raise the ceiling for web developers making games, visualizations, and
other sorts of demanding content.

:22

### Slide 2

In technical terms, WebGPU is a new DOM API that lets web content use
modern platform APIs to get at the machine's graphics processor.

Today, when web content wants to use the GPU, the means provided by
the web platform for doing so is the WebGL API. WebGL is based on
OpenGL ES, which is based on OpenGL, which was first designed in 1992.
1992 is the era of the Amiga, Silicon Graphics workstations, you know?
Things were a bit different then.

What's wrong with WebGL? Well, nothing - but let me lay out the
situation and see if it resembles any other key web technology you
might be familiar with.

WebGL performs fine. But because the API is just not an ideal match
for modern GPU architectures, the *reason* WebGL performs fine is that
there are incredible heroics going on underneath the hood, to pull all
sorts of tricks to make sure that common cases hit the hardware's
sweet spot. And developers know about these tricks, and try to
carefully structure their code to stay on the good path. But of
course, if you happen to get something wrong and end up on the device
driver's bad side, your performance goes off a cliff.

Did you figure it out? WebGL is the JavaScript of graphics APIs: very
fast, *if* you know exactly what you're doing.

In the 2010's, all the major platforms - Windows, Mac, Linux - came
out with a new generation of graphics APIs that give native developers
much more control over performance. WebGPU's goal is to bring those
benefits to web developers too.

1:52

### Slide 3

Here's the architecture of Firefox's WebGPU implementation.

The JavaScript interface is defined by WebIDL provided by the WebGPU
standards committee, which Mozilla participates in along with
folks from Google, Apple, Microsoft, and others.

We have a pretty standard implementation for those bindings, with some
Rust mixed in to communicate with the lower levels. Content's requests
are sent from the sandboxed content process to the GPU process for
execution.

Here's where things get interesting. The heart of Firefox's WebGPU
implementation is the `wgpu` crate, a high-performance, cross-platform
implementation of the heart of the WebGPU standard, written in Rust.
`wgpu` is an independent open-source project maintained on GitHub. As
you might guess, there are a *lot* of native developers a well-designed cross-platform GPU API is something
that a lot of native 
