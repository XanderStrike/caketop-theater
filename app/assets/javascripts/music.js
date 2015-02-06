var playing = false;

function start_playing() {
	playing = true;
	$('#playlist li a').click();
}

function play(elem) {
	$('.active').removeClass('active');
	set_song($(elem).attr('filename'));
	$(elem).addClass('active');
	$('#now-playing').html($(elem).attr('title') + ' - ' + $(elem).attr('artist'));
}

function next() {
	console.log($('.active').html())
	$('.active').parent().next().find('a').click();
}

function last() {
	console.log($('.active').html())
	$('.active').parent().prev().find('a').click();
}

function set_song(filename) {
	$('#nav-audio-source').attr('src', filename);
	var player = document.getElementById("nav-audio-controls");
	player.load();
	player.play();
}

function add(elem) {
	li = build_pl_item(
		$(elem).attr('artist'),
		$(elem).attr('album'),
		$(elem).attr('title'),
		$(elem).attr('filename')
		);
	$('#playlist').append(li);

	if (!playing) { start_playing(); }
}

function build_pl_item(artist, album, title, filename) {
	return '<li><a href="#" onClick="play(this)" class="playlist-elem" artist="' + artist + '" album="' + album + '" title="' + title + '" filename="' + filename + '">' + artist + " - " + title + "</a></li>";
}

$('#nav-audio-controls')[0].addEventListener('ended',function(e){
	next();
});
$('#forward').click(next);
$('#back').click(last);
$("#play-pause")[0].onclick = function(){
	if ($("#play-pause-span").hasClass("glyphicon-play")) {
		$("#play-pause-span").addClass("glyphicon-pause").removeClass("glyphicon-play");
		document.getElementById("nav-audio-controls").play();
	} else {
		$("#play-pause-span").addClass("glyphicon-play").removeClass("glyphicon-pause");
		document.getElementById("nav-audio-controls").pause();
	}
}

// load more when user hits bottom of page
$(window).scroll(function () {
	if ($(document).height() <= $(window).scrollTop() + $(window).height() + 200) {
		$("#more-link").click();
	}
});
