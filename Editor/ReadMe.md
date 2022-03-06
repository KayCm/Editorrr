Filters:
  T.. = Timeline support
  .S. = Slice threading
  ..C = Command support
  A = Audio input/output
  V = Video input/output
  N = Dynamic number and/or type of input/output
  | = Source or sink filter
 ... abench            A->A       Benchmark part of a filtergraph.
 ..C acompressor       A->A       Audio compressor.
 ... acontrast         A->A       Simple audio dynamic range compression/expansion filter.
 ... acopy             A->A       Copy the input audio unchanged to the output.
 ... acue              A->A       Delay filtering to match a cue.
 ... acrossfade        AA->A      Cross fade two input audio streams.
 .S. acrossover        A->N       Split audio into per-bands streams.
 ... acrusher          A->A       Reduce audio bit resolution.
 TS. adeclick          A->A       Remove impulsive noise from input audio.
 TS. adeclip           A->A       Remove clipping from input audio.
 T.. adelay            A->A       Delay one or more audio channels.
 ... aderivative       A->A       Compute derivative of input audio.
 ... aecho             A->A       Add echoing to the audio.
 ... aemphasis         A->A       Audio emphasis.
 ... aeval             A->A       Filter audio signal according to a specified expression.
 T.. afade             A->A       Fade in/out input audio.
 TSC afftdn            A->A       Denoise audio samples using FFT.
 ... afftfilt          A->A       Apply arbitrary expressions to samples in frequency domain.
 .SC afir              N->N       Apply Finite Impulse Response filter with supplied coefficients in additional stream(s).
 ... aformat           A->A       Convert the input audio to one of the specified formats.
 ... agate             A->A       Audio gate.
 .S. aiir              A->N       Apply Infinite Impulse Response filter with supplied coefficients.
 ... aintegral         A->A       Compute integral of input audio.
 ... ainterleave       N->A       Temporally interleave audio inputs.
 ... alimiter          A->A       Audio lookahead limiter.
 TSC allpass           A->A       Apply a two-pole all-pass filter.
 ... aloop             A->A       Loop audio samples.
 ... amerge            N->A       Merge two or more audio streams into a single multi-channel stream.
 T.. ametadata         A->A       Manipulate audio frame metadata.
 ..C amix              N->A       Audio mixing.
 ... amultiply         AA->A      Multiply two audio streams.
 ..C anequalizer       A->N       Apply high-order audio parametric multi band equalizer.
 TSC anlmdn            A->A       Reduce broadband noise from stream using Non-Local Means.
 .SC anlms             AA->A      Apply Normalized Least-Mean-Squares algorithm to first audio stream.
 ... anull             A->A       Pass the source unchanged to the output.
 T.. apad              A->A       Pad audio with silence.
 ... aperms            A->A       Set permissions for the output audio frame.
 ... aphaser           A->A       Add a phasing effect to the audio.
 ... apulsator         A->A       Audio pulsator.
 ... arealtime         A->A       Slow down filtering to match realtime.
 ... aresample         A->A       Resample audio data.
 ... areverse          A->A       Reverse an audio clip.
 .S. arnndn            A->A       Reduce noise from speech using Recurrent Neural Networks.
 ... aselect           A->N       Select audio frames to pass in output.
 ... asendcmd          A->A       Send commands to filters.
 ... asetnsamples      A->A       Set the number of samples for each output audio frames.
 ... asetpts           A->A       Set PTS for the output audio frame.
 ... asetrate          A->A       Change the sample rate without altering the data.
 ... asettb            A->A       Set timebase for the audio output link.
 ... ashowinfo         A->A       Show textual information for each audio frame.
 T.. asidedata         A->A       Manipulate audio frame side data.
 TSC asoftclip         A->A       Audio Soft Clipper.
 ... asplit            A->N       Pass on the audio input to N audio outputs.
 .S. astats            A->A       Show time domain statistics about audio frames.
 ..C astreamselect     N->N       Select audio streams
 ..C asubboost         A->A       Boost subwoofer frequencies.
 ..C atempo            A->A       Adjust audio tempo.
 ... atrim             A->A       Pick one continuous section from the input, drop the rest.
 ... axcorrelate       AA->A      Cross-correlate two audio streams.
 TSC bandpass          A->A       Apply a two-pole Butterworth band-pass filter.
 TSC bandreject        A->A       Apply a two-pole Butterworth band-reject filter.
 TSC bass              A->A       Boost or cut lower frequencies.
 TSC biquad            A->A       Apply a biquad IIR filter with the given coefficients.
 ... channelmap        A->A       Remap audio channels.
 ... channelsplit      A->N       Split audio into per-channel streams.
 ... chorus            A->A       Add a chorus effect to the audio.
 ... compand           A->A       Compress or expand audio dynamic range.
 ... compensationdelay A->A       Audio Compensation Delay Line.
 T.C crossfeed         A->A       Apply headphone crossfeed filter.
 TSC crystalizer       A->A       Simple expand audio dynamic range filter.
 T.. dcshift           A->A       Apply a DC shift to the audio.
 T.. deesser           A->A       Apply de-essing to the audio.
 ... drmeter           A->A       Measure audio dynamic range.
 T.C dynaudnorm        A->A       Dynamic Audio Normalizer.
 ... earwax            A->A       Widen the stereo image.
 ... ebur128           A->N       EBU R128 scanner.
 TSC equalizer         A->A       Apply two-pole peaking equalization (EQ) filter.
 T.C extrastereo       A->A       Increase difference between stereo audio channels.
 ..C firequalizer      A->A       Finite Impulse Response Equalizer.
 ... flanger           A->A       Apply a flanging effect to the audio.
 ... haas              A->A       Apply Haas Stereo Enhancer.
 ... hdcd              A->A       Apply High Definition Compatible Digital (HDCD) decoding.
 .S. headphone         N->A       Apply headphone binaural spatialization with HRTFs in additional streams.
 TSC highpass          A->A       Apply a high-pass filter with 3dB point frequency.
 TSC highshelf         A->A       Apply a high shelf filter.
 ... join              N->A       Join multiple audio streams into multi-channel output.
 ... loudnorm          A->A       EBU R128 loudness normalization
 TSC lowpass           A->A       Apply a low-pass filter with 3dB point frequency.
 TSC lowshelf          A->A       Apply a low shelf filter.
 ... mcompand          A->A       Multiband Compress or expand audio dynamic range.
 ... pan               A->A       Remix channels with coefficients (panning).
 ... replaygain        A->A       ReplayGain scanner.
 ..C sidechaincompress AA->A      Sidechain compressor.
 ... sidechaingate     AA->A      Audio sidechain gate.
 ... silencedetect     A->A       Detect silence.
 ... silenceremove     A->A       Remove silence.
 ... stereotools       A->A       Apply various stereo tools.
 T.C stereowiden       A->A       Apply stereo widening effect.
 ... superequalizer    A->A       Apply 18 band equalization filter.
 .S. surround          A->A       Apply audio surround upmix filter.
 TSC treble            A->A       Boost or cut upper frequencies.
 ... tremolo           A->A       Apply tremolo effect.
 ... vibrato           A->A       Apply vibrato effect.
 T.C volume            A->A       Change input volume.
 ... volumedetect      A->A       Detect audio volume.
 ... aevalsrc          |->A       Generate an audio signal generated by an expression.
 ... afirsrc           |->A       Generate a FIR coefficients audio stream.
 ... anoisesrc         |->A       Generate a noise audio signal.
 ... anullsrc          |->A       Null audio source, return empty audio frames.
 ... hilbert           |->A       Generate a Hilbert transform FIR coefficients.
 ... sinc              |->A       Generate a sinc kaiser-windowed low-pass, high-pass, band-pass, or band-reject FIR coefficients.
 ... sine              |->A       Generate sine wave audio signal.
 ... anullsink         A->|       Do absolutely nothing with the input audio.
 ... addroi            V->V       Add region of interest to frame.
 ... alphaextract      V->N       Extract an alpha channel as a grayscale image component.
 T.. alphamerge        VV->V      Copy the luma value of the second input into the alpha channel of the first input.
 TSC amplify           V->V       Amplify changes between successive video frames.
 TSC atadenoise        V->V       Apply an Adaptive Temporal Averaging Denoiser.
 TSC avgblur           V->V       Apply Average Blur filter.
 T.. bbox              V->V       Compute bounding box for each frame.
 ... bench             V->V       Benchmark part of a filtergraph.
 T.. bilateral         V->V       Apply Bilateral filter.
 T.. bitplanenoise     V->V       Measure bit plane noise.
 ... blackdetect       V->V       Detect video intervals that are (almost) black.
 ... blackframe        V->V       Detect frames that are (almost) black.
 TS. blend             VV->V      Blend two video frames into each other.
 TS. bm3d              N->V       Block-Matching 3D denoiser.
 T.. boxblur           V->V       Blur the input.
 TS. bwdif             V->V       Deinterlace the input image.
 TSC cas               V->V       Contrast Adaptive Sharpen.
 TSC chromahold        V->V       Turns a certain color range into gray.
 TSC chromakey         V->V       Turns a certain color into transparency. Operates on YUV colors.
 TSC chromashift       V->V       Shift chroma.
 ... ciescope          V->V       Video CIE scope.
 T.. codecview         V->V       Visualize information about some codecs.
 TSC colorbalance      V->V       Adjust the color balance.
 TSC colorchannelmixer V->V       Adjust colors by mixing color channels.
 TSC colorkey          V->V       Turns a certain color into transparency. Operates on RGB colors.
 TSC colorhold         V->V       Turns a certain color range into gray. Operates on RGB colors.
 TSC colorlevels       V->V       Adjust the color levels.
 TS. colormatrix       V->V       Convert color matrix.
 TS. colorspace        V->V       Convert between colorspaces.
 TS. convolution       V->V       Apply convolution filter.
 TS. convolve          VV->V      Convolve first video stream with second video stream.
 ... copy              V->V       Copy the input video unchanged to the output.
 ... cover_rect        V->V       Find and cover a user specified object.
 ..C crop              V->V       Crop the input video.
 T.. cropdetect        V->V       Auto-detect crop size.
 ... cue               V->V       Delay filtering to match a cue.
 TS. curves            V->V       Adjust components curves.
 .S. datascope         V->V       Video data analysis.
 T.C dblur             V->V       Apply Directional Blur filter.
 TS. dctdnoiz          V->V       Denoise frames using 2D DCT.
 TS. deband            V->V       Debands video.
 T.. deblock           V->V       Deblock video.
 ... decimate          N->V       Decimate frames (post field matching filter).
 TS. deconvolve        VV->V      Deconvolve first video stream with second video stream.
 TS. dedot             V->V       Reduce cross-luminance and cross-color.
 TSC deflate           V->V       Apply deflate effect.
 ... deflicker         V->V       Remove temporal frame luminance variations.
 ... dejudder          V->V       Remove judder produced by pullup.
 T.. delogo            V->V       Remove logo from input video.
 T.. derain            V->V       Apply derain filter to the input.
 ... deshake           V->V       Stabilize shaky video.
 TS. despill           V->V       Despill video.
 ... detelecine        V->V       Apply an inverse telecine pattern.
 TSC dilation          V->V       Apply dilation effect.
 T.. displace          VVV->V     Displace pixels.
 ... dnn_processing    V->V       Apply DNN processing filter to the input.
 ... doubleweave       V->V       Weave input video fields into double number of frames.
 T.C drawbox           V->V       Draw a colored box on the input video.
 ... drawgraph         V->V       Draw a graph using input video metadata.
 T.C drawgrid          V->V       Draw a colored grid on the input video.
 T.. edgedetect        V->V       Detect and draw edge.
 ... elbg              V->V       Apply posterize effect, using the ELBG algorithm.
 T.. entropy           V->V       Measure video frames entropy.
 T.C eq                V->V       Adjust brightness, contrast, gamma, and saturation.
 TSC erosion           V->V       Apply erosion effect.
 ... extractplanes     V->N       Extract planes as grayscale frames.
 .S. fade              V->V       Fade in/out input video.
 T.. fftdnoiz          V->V       Denoise frames using 3D FFT.
 T.. fftfilt           V->V       Apply arbitrary expressions to pixels in frequency domain.
 ... field             V->V       Extract a field from the input video.
 ... fieldhint         V->V       Field matching using hints.
 ... fieldmatch        N->V       Field matching for inverse telecine.
 T.. fieldorder        V->V       Set the field order.
 T.C fillborders       V->V       Fill borders of the input video.
 ... find_rect         V->V       Find a user specified object.
 T.. floodfill         V->V       Fill area with same color with another color.
 ... format            V->V       Convert the input video to one of the specified pixel formats.
 ... fps               V->V       Force constant framerate.
 ... framepack         VV->V      Generate a frame packed stereoscopic video.
 .S. framerate         V->V       Upsamples or downsamples progressive source between specified frame rates.
 T.. framestep         V->V       Select one frame every N frames.
 ... freezedetect      V->V       Detects frozen video input.
 ... freezeframes      VV->V      Freeze video frames.
 T.. fspp              V->V       Apply Fast Simple Post-processing filter.
 TSC gblur             V->V       Apply Gaussian Blur filter.
 TS. geq               V->V       Apply generic equation to each pixel.
 T.. gradfun           V->V       Debands video quickly using gradients.
 ... graphmonitor      V->V       Show various filtergraph stats.
 TS. greyedge          V->V       Estimates scene illumination by grey edge assumption.
 TS. haldclut          VV->V      Adjust colors using a Hald CLUT.
 TS. hflip             V->V       Horizontally flip the input video.
 T.. histeq            V->V       Apply global color histogram equalization.
 ... histogram         V->V       Compute and draw a histogram.
 TSC hqdn3d            V->V       Apply a High Quality 3D Denoiser.
 .S. hqx               V->V       Scale the input by 2, 3 or 4 using the hq*x magnification algorithm.
 .S. hstack            N->V       Stack video inputs horizontally.
 T.C hue               V->V       Adjust the hue and saturation of the input video.
 ... hwdownload        V->V       Download a hardware frame to a normal frame
 ... hwmap             V->V       Map hardware frames
 ... hwupload          V->V       Upload a normal frame to a hardware frame
 T.. hysteresis        VV->V      Grow first stream into second stream by connecting components.
 ... idet              V->V       Interlace detect Filter.
 T.C il                V->V       Deinterleave or interleave fields.
 TSC inflate           V->V       Apply inflate effect.
 ... interlace         V->V       Convert progressive video into interlaced.
 ... interleave        N->V       Temporally interleave video inputs.
 ... kerndeint         V->V       Apply kernel deinterlacing to the input.
 .S. lagfun            V->V       Slowly update darker pixels.
 .S. lenscorrection    V->V       Rectify the image by correcting for lens distortion.
 TS. limiter           V->V       Limit pixels components to the specified range.
 ... loop              V->V       Loop video frames.
 TSC lumakey           V->V       Turns a certain luma into transparency.
 TS. lut               V->V       Compute and apply a lookup table to the RGB/YUV input video.
 TS. lut1d             V->V       Adjust colors using a 1D LUT.
 TS. lut2              VV->V      Compute and apply a lookup table from two video inputs.
 TS. lut3d             V->V       Adjust colors using a 3D LUT.
 TS. lutrgb            V->V       Compute and apply a lookup table to the RGB input video.
 TS. lutyuv            V->V       Compute and apply a lookup table to the YUV input video.
 TS. maskedclamp       VVV->V     Clamp first stream with second stream and third stream.
 TS. maskedmax         VVV->V     Apply filtering with maximum difference of two streams.
 TS. maskedmerge       VVV->V     Merge first stream with second stream using third stream as mask.
 TS. maskedmin         VVV->V     Apply filtering with minimum difference of two streams.
 TS. maskedthreshold   VV->V      Pick pixels comparing absolute difference of two streams with threshold.
 TS. maskfun           V->V       Create Mask.
 ... mcdeint           V->V       Apply motion compensating deinterlacing.
 TSC median            V->V       Apply Median filter.
 ... mergeplanes       N->V       Merge planes.
 ... mestimate         V->V       Generate motion vectors.
 T.. metadata          V->V       Manipulate video frame metadata.
 T.. midequalizer      VV->V      Apply Midway Equalization.
 ... minterpolate      V->V       Frame rate conversion using Motion Interpolation.
 .S. mix               N->V       Mix video inputs.
 ... mpdecimate        V->V       Remove near-duplicate frames.
 TS. negate            V->V       Negate input video.
 TS. nlmeans           V->V       Non-local means denoiser.
 T.. nnedi             V->V       Apply neural network edge directed interpolation intra-only deinterlacer.
 ... noformat          V->V       Force libavfilter not to use any of the specified pixel formats for the input to the next filter.
 TS. noise             V->V       Add noise.
 T.C normalize         V->V       Normalize RGB video.
 ... null              V->V       Pass the source unchanged to the output.
 T.C oscilloscope      V->V       2D Video Oscilloscope.
 TSC overlay           VV->V      Overlay a video source on top of the input.
 T.. owdenoise         V->V       Denoise using wavelets.
 ... pad               V->V       Pad the input video.
 ... palettegen        V->V       Find the optimal palette for a given stream.
 ... paletteuse        VV->V      Use a palette to downsample an input video stream.
 ... perms             V->V       Set permissions for the output video frame.
 TS. perspective       V->V       Correct the perspective of video.
 T.. phase             V->V       Phase shift fields.
 ... photosensitivity  V->V       Filter out photosensitive epilepsy seizure-inducing flashes.
 ... pixdesctest       V->V       Test pixel format definitions.
 T.. pixscope          V->V       Pixel data analysis.
 T.C pp                V->V       Filter video using libpostproc.
 T.. pp7               V->V       Apply Postprocessing 7 filter.
 TS. premultiply       N->V       PreMultiply first stream with first plane of second stream.
 TS. prewitt           V->V       Apply prewitt operator.
 T.. pseudocolor       V->V       Make pseudocolored video frames.
 ... psnr              VV->V      Calculate the PSNR between two video streams.
 ... pullup            V->V       Pullup from field sequence to frames.
 T.. qp                V->V       Change video quantization parameters.
 ... random            V->V       Return random frames.
 T.. readeia608        V->V       Read EIA-608 Closed Caption codes from input video and write them to frame metadata.
 ... readvitc          V->V       Read vertical interval timecode and write it to frame metadata.
 ... realtime          V->V       Slow down filtering to match realtime.
 TS. remap             VVV->V     Remap pixels.
 TS. removegrain       V->V       Remove grain.
 T.. removelogo        V->V       Remove a TV logo based on a mask image.
 ... repeatfields      V->V       Hard repeat fields based on MPEG repeat field flag.
 ... reverse           V->V       Reverse a clip.
 TSC rgbashift         V->V       Shift RGBA.
 TS. roberts           V->V       Apply roberts cross operator.
 TSC rotate            V->V       Rotate the input image.
 T.. sab               V->V       Apply shape adaptive blur.
 ..C scale             V->V       Scale the input video size and/or convert the image format.
 ..C scale2ref         VV->VV     Scale the input video size and/or convert the image format to the given reference.
 ... scdet             V->V       Detect video scene change
 TSC scroll            V->V       Scroll input video.
 ... select            V->N       Select video frames to pass in output.
 TS. selectivecolor    V->V       Apply CMYK adjustments to specific color ranges.
 ... sendcmd           V->V       Send commands to filters.
 ... separatefields    V->V       Split input video frames into fields.
 ... setdar            V->V       Set the frame display aspect ratio.
 ... setfield          V->V       Force field for the output video frame.
 ... setparams         V->V       Force field, or color property for the output video frame.
 ... setpts            V->V       Set PTS for the output video frame.
 ... setrange          V->V       Force color range for the output video frame.
 ... setsar            V->V       Set the pixel sample aspect ratio.
 ... settb             V->V       Set timebase for the video output link.
 ... showinfo          V->V       Show textual information for each video frame.
 ... showpalette       V->V       Display frame palette.
 T.. shuffleframes     V->V       Shuffle video frames.
 T.. shuffleplanes     V->V       Shuffle video planes.
 T.. sidedata          V->V       Manipulate video frame side data.
 .S. signalstats       V->V       Generate statistics from video analysis.
 ... signature         N->V       Calculate the MPEG-7 video signature
 T.. smartblur         V->V       Blur the input video without impacting the outlines.
 TS. sobel             V->V       Apply sobel operator.
 ... split             V->N       Pass on the input to N video outputs.
 T.C spp               V->V       Apply a simple post processing filter.
 ... sr                V->V       Apply DNN-based image super resolution to the input.
 ... ssim              VV->V      Calculate the SSIM between two video streams.
 .S. stereo3d          V->V       Convert video stereoscopic 3D view.
 ..C streamselect      N->N       Select video streams
 ... super2xsai        V->V       Scale the input by 2x using the Super2xSaI pixel art algorithm.
 T.. swaprect          V->V       Swap 2 rectangular objects in video.
 T.. swapuv            V->V       Swap U and V components.
 TS. tblend            V->V       Blend successive frames.
 ... telecine          V->V       Apply a telecine pattern.
 ... thistogram        V->V       Compute and draw a temporal histogram.
 TS. threshold         VVVV->V    Threshold first video stream using other video streams.
 T.. thumbnail         V->V       Select the most representative frame in a given sequence of consecutive frames.
 ... tile              V->V       Tile several successive frames together.
 ... tinterlace        V->V       Perform temporal field interlacing.
 TS. tlut2             V->V       Compute and apply a lookup table from two successive frames.
 TS. tmedian           V->V       Pick median pixels from successive frames.
 TS. tmix              V->V       Mix successive video frames.
 .S. tonemap           V->V       Conversion to/from different dynamic ranges.
 ... tpad              V->V       Temporarily pad video frames.
 .S. transpose         V->V       Transpose input video.
 ... trim              V->V       Pick one continuous section from the input, drop the rest.
 TS. unpremultiply     N->V       UnPreMultiply first stream with first plane of second stream.
 TS. unsharp           V->V       Sharpen or blur the input video.
 ... untile            V->V       Untile a frame into a sequence of frames.
 T.. uspp              V->V       Apply Ultra Simple / Slow Post-processing filter.
 .SC v360              V->V       Convert 360 projection of video.
 T.. vaguedenoiser     V->V       Apply a Wavelet based Denoiser.
 ... vectorscope       V->V       Video vectorscope.
 T.. vflip             V->V       Flip the input video vertically.
 ... vfrdet            V->V       Variable frame rate detect filter.
 TSC vibrance          V->V       Boost or alter saturation.
 T.. vignette          V->V       Make or reverse a vignette effect.
 ... vmafmotion        V->V       Calculate the VMAF Motion score.
 .S. vstack            N->V       Stack video inputs vertically.
 TS. w3fdif            V->V       Apply Martin Weston three field deinterlace.
 .S. waveform          V->V       Video waveform monitor.
 ... weave             V->V       Weave input video fields into frames.
 .S. xbr               V->V       Scale the input using xBR algorithm.
 .S. xfade             VV->V      Cross fade one video with another video.
 .S. xmedian           N->V       Pick median pixels from several video inputs.
 .S. xstack            N->V       Stack video inputs into custom layout.
 TS. yadif             V->V       Deinterlace the input image.
 TSC yaepblur          V->V       Yet another edge preserving blur filter.
 ... zoompan           V->V       Apply Zoom & Pan effect.
 ... allrgb            |->V       Generate all RGB colors.
 ... allyuv            |->V       Generate all yuv colors.
 ... cellauto          |->V       Create pattern generated by an elementary cellular automaton.
 ..C color             |->V       Provide an uniformly colored input.
 .S. gradients         |->V       Draw a gradients.
 ... haldclutsrc       |->V       Provide an identity Hald CLUT.
 ... life              |->V       Create life.
 ... mandelbrot        |->V       Render a Mandelbrot fractal.
 ... mptestsrc         |->V       Generate various test pattern.
 ... nullsrc           |->V       Null video source, return unprocessed video frames.
 ... pal75bars         |->V       Generate PAL 75% color bars.
 ... pal100bars        |->V       Generate PAL 100% color bars.
 ... rgbtestsrc        |->V       Generate RGB test pattern.
 .S. sierpinski        |->V       Render a Sierpinski fractal.
 ... smptebars         |->V       Generate SMPTE color bars.
 ... smptehdbars       |->V       Generate SMPTE HD color bars.
 ... testsrc           |->V       Generate test pattern.
 ... testsrc2          |->V       Generate another test pattern.
 ... yuvtestsrc        |->V       Generate YUV test pattern.
 ... nullsink          V->|       Do absolutely nothing with the input video.
 ... abitscope         A->V       Convert input audio to audio bit scope video output.
 ... adrawgraph        A->V       Draw a graph using input audio metadata.
 ... agraphmonitor     A->V       Show various filtergraph stats.
 ... ahistogram        A->V       Convert input audio to histogram video output.
 ... aphasemeter       A->N       Convert input audio to phase meter video output.
 ... avectorscope      A->V       Convert input audio to vectorscope video output.
 ..C concat            N->N       Concatenate audio and video streams.
 ... showcqt           A->V       Convert input audio to a CQT (Constant/Clamped Q Transform) spectrum video output.
 ... showfreqs         A->V       Convert input audio to a frequencies video output.
 .S. showspatial       A->V       Convert input audio to a spatial video output.
 .S. showspectrum      A->V       Convert input audio to a spectrum video output.
 .S. showspectrumpic   A->V       Convert input audio to a spectrum video output single picture.
 ... showvolume        A->V       Convert input audio volume to video output.
 ... showwaves         A->V       Convert input audio to a video output.
 ... showwavespic      A->V       Convert input audio to a video output single picture.
 ... spectrumsynth     VV->A      Convert input spectrum videos to audio output.
 ..C amovie            |->N       Read audio from a movie source.
 ..C movie             |->N       Read from a movie source.
 ... afifo             A->A       Buffer input frames and send them when they are requested.
 ... fifo              V->V       Buffer input images and send them when they are requested.
 ... abuffer           |->A       Buffer audio frames, and make them accessible to the filterchain.
 ... buffer            |->V       Buffer video frames, and make them accessible to the filterchain.
 ... abuffersink       A->|       Buffer audio frames, and make them available to the end of the filter graph.
 ... buffersink        V->|       Buffer video frames, and make them available to the end of the filter graph.