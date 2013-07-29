// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
//win.add(label);

var btn = Ti.UI.createButton({
	title: "Open Image Editor"
});

//win.add(btn);
win.rightNavButton = btn;
win.open({modal:true});

var iv = Ti.UI.createImageView({
	width: 200,
	image: 'pippo.jpg'
});

win.add(iv);



// TODO: write your module tests here
var TiCropImageEditor = require('it.etnatraining.TiCIE');
Ti.API.info("module is => " + TiCropImageEditor);

var imageEditor = TiCropImageEditor.createImageEditor();
Ti.API.info(imageEditor);

imageEditor.addEventListener("done", function(e) {
	iv.image = e.image;
});


btn.addEventListener('click', function() {
	Ti.Media.openPhotoGallery({
		success: function(e) {
			imageEditor.open(e.media);
		}
	});
	
});





//label.text = TiCropImageEditor.example();

//Ti.API.info("module exampleProp is => " + TiCropImageEditor.exampleProp);
//TiCropImageEditor.exampleProp = "This is a test value";

if (Ti.Platform.name == "android") {
	var proxy = TiCropImageEditor.createExample({
		message: "Creating an example Proxy",
		backgroundColor: "red",
		width: 100,
		height: 100,
		top: 100,
		left: 150
	});

	proxy.printMessage("Hello world!");
	proxy.message = "Hi world!.  It's me again.";
	proxy.printMessage("Hello world!");
	win.add(proxy);
}

