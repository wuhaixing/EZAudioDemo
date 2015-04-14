# EZAudioDemo
Use EZAudio in Swift,draw Plot for audio from microphone 

1. Create *EZAudioDemo-Bridging-Header.h*,import EZAudio.h
2. Create *PrefixHeader.pch*
3. Change Project Settings:
  1. Set Build Settings->Search Paths - Header Search Paths,add EZAudio's header files by drag header files in EZAudio directory to it
  2. Set Build Settings->Swift Compiler - Code Generation -> Objective-C Bridging Header to *EZAudioDemo-Bridging-Header.h*
  2. Set Build Settings->Apple LLVM 6.1 - Language->Prefix Header to *PrefixHeader.pch*
  3. Set Build Phases->Compile Sources,add EZAudio source code by drag Souce files in EZAudio directory to it
4. Add UIView into Main.storyboard,change it's class to EZAudioPlotGL
5. Create microphone function:

```
    func microphone(microphone: EZMicrophone!,
        hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>,
        withBufferSize bufferSize: UInt32,
        withNumberOfChannels numberOfChannels: UInt32) {
        dispatch_async(dispatch_get_main_queue()) {
            self.audioPlot.updateBuffer(buffer.memory, withBufferSize: bufferSize)
        }
    }
```

