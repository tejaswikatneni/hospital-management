var onReady = function(){
	jQuery(function() {
		var completer;

		completer = new GmapsCompleter({
		inputField: '#gmaps-input-address',
		errorField: '#gmaps-error'
		});

		completer.autoCompleteInit({
		country: "us"
		});
	});
}
jQuery(document).ready(onReady);
jQuery(document).on('page:load', onReady);