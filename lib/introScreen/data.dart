class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Secure and Fast for online transaction.");
  sliderModel.setTitle("Encrypted");
  sliderModel.setImageAssetPath("img/sp2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Hundreds of your favourite Artists Art in just one place.");
  sliderModel.setTitle("Easy to use");
  sliderModel.setImageAssetPath("img/sp1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Are you an Artist yourself, put your art for free to sell.");
  sliderModel.setTitle("Sell Your Art");
  sliderModel.setImageAssetPath("img/sp3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}