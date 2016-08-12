var ready = function() {
	// $("ul.side-nav li").click(function(e){
	// 	$("li.active").toggleClass("active");
	// 	$(this).toggleClass("active");
	// });
	$(".dropdown-toggle").dropdown();
};

$(document).off().on('turbolinks:load', ready);