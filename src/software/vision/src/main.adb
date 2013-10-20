with visionBindings_hpp; use visionBindings_hpp;
with interfaces.C.strings; use interfaces.C.strings;
with interfaces.C; use interfaces.C;
with Vision.Image_Processing;
with Ada.Containers.Vectors; use Ada.Containers;

procedure main is
  -- package Number_Container is new vectors (Natural,Natural);
  -- hsiSize :Number_Container.Vector;

   iImageSource : Interfaces.C.Int;
   iImageDestination : Interfaces.C.Int;
   iCannyLocation : Interfaces.C.Int;
   iGreyScaleLocation : Interfaces.C.Int;
   iHSILocation : Interfaces.C.Int;

   iImageCannyOut : integer;
   iGreyFilter : Interfaces.C.Int;
   iHSIFilter : Interfaces.C.Int;
   iCannyKernelSize :Interfaces.C.int;
   iCannyLowThres : Interfaces.C.int;
   iCannyHighThres : Interfaces.C.int;
   ret : Interfaces.C.int;

   --hough cirlces variables
   inverseRatioOfResolution : Interfaces.C.int;
   minDistBetweenCenters : Interfaces.C.int;
   houghCannyUpThres : Interfaces.C.int;
   centerDetectionThreshold : Interfaces.C.int;
   minRadius : Interfaces.C.int;
   maxRadius : Interfaces.C.int;

   --histo variables
   rangeLower : Standard.Float;
   rangeHigher : Standard.Float;
   histSize : Interfaces.C.Int;
   --hsiSize : Vector;

   CoreWrap : aliased Class_Core_Wrap.Core_Wrap;
   processingWrap : aliased Class_Processing_Wrap.Processing_Wrap;
   preprocessingWrap : aliased Class_Preprocessing_Wrap.Preprocessing_Wrap;

begin
  -- hsiSize:=(30,32);
   --image index
   iImageSource := 0;
   iImageDestination := 1;
   iGreyScaleLocation :=20;
   iCannyLocation :=21;
   iHSILocation := 22;

   iImageCannyOut := 4;
   iGreyFilter := 6;
   iHSIFilter :=40;
   iCannyLowThres := 20;
   iCannyHighThres := 200;
   iCannyKernelSize := 3;

--histo
   rangeLower := 0.0;
   rangeHigher :=256.0;
   histSize :=256;

   --hough circle declarations
   --src use destination of canny as source for hough circles
     inverseRatioOfResolution := 1;
   minDistBetweenCenters := 10;
   houghCannyUpThres := 200;
   centerDetectionThreshold := 100;
   minRadius := 0;--zero used if unknown
   maxRadius :=	 0;--zero used if unknown

   --CHECK FOR INSTRUCTION--to be implemented, for now just working on default mode

-----------------------------MAIN LOOP --------------------------------------------------------
 -- Endless_Loop:
  -- loop
   --GET IMAGE-- read from buffer
   CoreWrap.img_buffer;--load image to img.at(0)

   --, or just read in single image NEW, READS IN IMAGE AND STORES IN INDEX "IMAGESOURCE" OF "img.at()"
   CoreWrap.imstore(iImageSource,New_String("Red_Green_Blue.jpg"));
   CoreWrap.imshow(New_String("Why so normal?"), iImageSource);--show image for debug purposes
   CoreWrap.waitKey(0);

   --split channels of image
   processingWrap.splitChannels(iImageSource);
   --run bgr histo and show result
   processingWrap.BGRHistogram(histSize, rangeLower, rangeHigher);
   processingWrap.showBGRHistogram(histSize);

   --convert image to hsi
   processingWrap.cvtColor(iImageSource, iHSILocation, iHSIFilter);
   CoreWrap.imshow(New_String("Why so HSI?"),iHSILocation);
   CoreWrap.waitKey(0);
   --hsi histo

   processingWrap.HSIHistogram(iHSILocation);

   --CLEAN IMAGE--to be implemented
   --CONVERT IMAGE TO GREYSCALE
   processingWrap.cvtColor(iImageSource,iGreyScaleLocation, iGreyFilter);
   CoreWrap.imshow(New_String("why so grey?"), iGreyScaleLocation);--show image for debug purposes
   CoreWrap.waitKey(0);

   --USE CANNY ON GREYSCALE IMAGE
   processingWrap.Canny(iGreyScaleLocation,iCannyLocation, iCannyLowThres, iCannyHighThres, iCannyKernelSize);
   CoreWrap.imshow(New_String("why so canny?"), iCannyLocation);--show image for debug purposes
   CoreWrap.waitKey(0);

      --test Channels
      --processingWrap.splitChannels(iImageSource);
      --processingWrap.showRedChannel;

   --ret := CoreWrap.imwrite(name => New_String("CannyOut.jpg"),
   --                      src  => 2 );
   --CoreWrap.push_back(New_String("CannyOut.jpg"));

   --HOUGH CIRCLES
   --     Vision.Image_Processing.Hough_Circles(iImageDestination, inverseRatioOfResolution, minDistBetweenCenters, houghCannyUpThres, centerDetectionThreshold, minRadius, maxRadius);
   --     Vision.Image_Processing.Draw_Hough_Circles(iImageSource);
   --     CoreWrap.imshow(New_String("why so circly?"), 1);--show image for debug purposes
   --     CoreWrap.waitKey(0);
   --     ret := CoreWrap.imwrite(name => New_String("HoughOut.jpg"),
   --                      src  => 1 );


   --HOUGH CIRCLES
   -- Vision.Image_Processing.Hough_Circles(iImageDestination, inverseRatioOfResolution, minDistBetweenCenters, houghCannyUpThres, centerDetectionThreshold, minRadius, maxRadius);
   -- Vision.Image_Processing.Draw_Hough_Circles(iImageSource);
   --CoreWrap.imshow(New_String("why so circly?"), 1);--show image for debug purposes
   --CoreWrap.waitKey(0);
   --Put("here now");
   --CoreWrap.waitKey(0);

   --HOUGH LINES
   --Vision.Image_Processing.Convert_To_Greyscale(iImageDestination,iImageSource, 8);
   --CoreWrap.imshow(New_String("back to BGR"), 1);--show image for debug purposes
   --CoreWrap.waitKey(0);

   --processingWrap.HoughLines(src                   => Interfaces.C.int(iImageDestination),
   --                        rho                   => 1,
   --                      theta                 => Standard.Float(1),
   --                    intersectionThreshold => 100);
   --processingWrap.DrawHoughLines(cdst => Interfaces.C.int(iImageSource));
   --CoreWrap.imshow(name => New_String("Lines disp"),
   --              src  => Interfaces.C.int(iImageSource));
   --CoreWrap.waitKey(0);
   --processingWrap.LabelPoints(Interfaces.C.int(2));
   --  Vision.Image_Processing.Convert_To_Greyscale(iImageDestination,iImageSource, 8);
   --  CoreWrap.imshow(New_String("back to BGR"), 1);--show image for debug purposes
   --  CoreWrap.waitKey(0);

   --     processingWrap.HoughLines(src                   => Interfaces.C.int(iImageDestination),
   --                               rho                   => 1,
   --                               theta                 => Standard.Float(1),
   --                               intersectionThreshold => 2);
   --     processingWrap.DrawHoughLines(cdst => Interfaces.C.int(iImageSource));
   --     CoreWrap.imshow(name => New_String("Lines disp"),
   --                     src  => Interfaces.C.int(iImageSource));
   --     CoreWrap.waitKey(0);

   --lines
   --processingWrap.LabelPoints(Interfaces.C.int(4));

   --Contours

    -- CoreWrap.imshow(name => New_String("test_disp"),
      --               src  => 1);
   --CoreWrap.waitKey(0);

   processingWrap.HoughCircles(iGreyScaleLocation, inverseRatioOfResolution, minDistBetweenCenters, houghCannyUpThres, centerDetectionThreshold, minRadius, maxRadius);


   processingWrap.Contours(iCannyLocation);
   processingWrap.showContours(contourOut => iImageSource,
                               contourId  => -1 ,
                               thickness  => 3 );
   CoreWrap.imshow(name => New_String("Whats with the contours?"),
                   src  => 0);
   CoreWrap.waitKey(0);
   --processingWrap.HoughCircles(Interfaces.C.int(1), inverseRatioOfResolution, minDistBetweenCenters, houghCannyUpThres, centerDetectionThreshold, minRadius, maxRadius);
   --ret := CoreWrap.imwrite(name => New_String("Contours.jpg"),
            --               src  => 0);

   processingWrap.approxPolyDP(1.2, 1);

  --end loop Endless_Loop;

end main;


--LOOP:
--//look for instruction

-- if instruction
--//go to mission wrap

--else
--//dont go to mission wrap!
--	//get image
--	//clean image
--	//find/calculate position/velocity
--	//check for object
--		if ojbect detected
--			//figure out what oject is
--			//figure out where object is
--
--END LOOP
