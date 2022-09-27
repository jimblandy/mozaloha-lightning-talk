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
for modern GPU architectures, the **reason** WebGL performs fine is that
there are incredible heroics going on underneath the hood, to pull all
sorts of tricks to make sure that common cases hit the hardware's
sweet spot. And developers know about these tricks, and try to
carefully structure their code to stay on the good path. But of
course, if you happen to get something wrong and end up on the device
driver's bad side, your performance goes off a cliff.

Did you figure it out? WebGL is the JavaScript of graphics APIs: very
fast, **if** you know exactly what you're doing.

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

In Firefox, we have a pretty standard implementation for those
bindings, with some Rust mixed in to communicate with the lower
levels. Content's requests are sent from the sandboxed content process
to the GPU process for execution.

Here's where things get interesting. The heart of Firefox's WebGPU
implementation is the `wgpu-core` crate, a high-performance,
cross-platform implementation of the heart of the WebGPU standard,
written in Rust. `wgpu-core` is part of `wgpu`, an independent
open-source project maintained on GitHub.

As you might guess, there are a **lot** of native developers out there
interested in a well-designed cross-platform GPU API. So `wgpu` is a
very active, healthy open-source project, with many talented
contributors from outside Mozilla. It's a classic open-source
success story.

2:35

### Slide 4

To serve those audiences, the `wgpu` crate provides an idiomatic
Rustic interface, and the `wgpu-native` crate provides an API designed
to be called from C or C++, and on top of that we have bindings for
many other languages: Python, Go, Java, C#, and others. So you can
really use the spirit of WebGPU anywhere you like.

3:11

### Slide 5

Okay! Let me try to get across the cool part of the WebGPU API in
sixty seconds!

WebGPU makes you record the series of graphics operations you want to
perform in advance, in a **command buffer**, which you submit to the
GPU for execution. This gives drivers a chance to look over the entire
batch of commands at once and look for optimization opportunities.

You can also make pre-recorded **bundles**, that you can use over and
over again. JavaScript content loves this, because you can do a whole
batch of work with a single call into native code.

When you hand WebGPU the code you want to run on the GPU, it gives you
back a **module**. You combine a module with the rest of the
information explaining how you want things drawn to build a
**pipeline**. Then you use that pipeline in **render passes**, series
of commands that actually draw stuff. Each of these stages is
validated in advance, so that by the time you actually submit your
command buffer to the GPU, it's ready to go.

In the future, WebGPU will let you do all this stuff on a worker
thread, but that's not going to be in v1.

WebGPU also introduces **compute pipelines**, which let you run pure
computation on the GPU, no pixels involved. This is great for taking
advantage of the amazing computational capacities in modern GPUs. But
of course compute pipelines and graphics pipelines can work together.

4:22

### Slide 6

If you would like to try out webgpu in Firefox today, flip the
`dom.webgpu.enabled` pref, and visit `wgpu.rs`.

### Slide 7

If you want to try `wgpu` for native development, head to the `gfx-rs`
organization on GitHub, check out the `wgpu` crate, and try running
one of the examples. This is so much fun.

### Slide 8

I hope I've managed to get across why we're excited about getting
WebGPU ready to ship to Firefox's users. You can reach me on Matrix,
by email, or find me in person - that's my photo up there.

Thanks for listening! 
