/*
  This sketch takes a directory of images and averages their pixels into a single image.
  Requirements:
    * All images must be the same resolution
    * All images must be sequenced in their named folder with a number. The folder lives in the data directory relative to this sketch.
    * when numbering your images pad them with the appropriate 0s
    * 0 must be your first sequence number
    * i.e. data/happy/002.jpg
    * Adobe bridge is very helpful for the batch renaming of images
*/

void setup() {
  //reference the name of the image folder you'll be using in the data directory to hold your images
  String seqName = "happy";
  //how many total images?
  int seqCount = 100;
  //how many digits are in the image's sequence value
  String digits = "000";
  int digitCount = 3;
  
  //images must all be cropped to the same resolution
  //set the canvas size equal to your image resolution
  size(306, 306);
  int resX = width;
  int resY = height;
  PImage imgsIn[] = new PImage[seqCount];
  println("loading in images...");
  for (int i = 0; i < imgsIn.length; i++) {
    String seq = digits + i;
    //set the image name based on which image this happens to be
    String imgName = "data/" + seqName + "/" + seq.substring(seq.length() - digitCount, seq.length()) + ".jpg";
    imgsIn[i] = loadImage(imgName);
    //load that specific image's pixels into memory
    imgsIn[i].loadPixels();
  }
  //create a pimage for the final product
  PImage finalImg = createImage(resX, resY, RGB);
  finalImg.loadPixels();
  //create total red green and blue values
  int redTotal, greenTotal, blueTotal;
  int pixelLimit = resX * resY;
  println("averaging pixels...");
  int imgsCount = imgsIn.length;
  //for each pixel...
  for (int i = 0; i < pixelLimit; i++) {
    //make sure all cumulative values are set to 0 at first
    redTotal = 0;
    greenTotal = 0;
    blueTotal = 0;
    //for each image add that pixel's red green and blue to cumulative values
    for (int j = 0; j < imgsCount; j++) {
      redTotal += red(imgsIn[j].pixels[i]);
      greenTotal += green(imgsIn[j].pixels[i]);
      blueTotal += blue(imgsIn[j].pixels[i]);
    }
    //add a pixel to your final image that is the average color of the input colors
    finalImg.pixels[i] = color(redTotal/imgsCount, greenTotal/imgsCount, blueTotal/imgsCount);
  }
  println("final image averaged");
  //update your final images pixels
  finalImg.updatePixels();
  //write the final image out to the canvas
  image(finalImg, 0, 0);
  
}