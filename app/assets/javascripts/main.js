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

	setTimeout( "jQuery('.alert, .notice').hide();", 5000 );
}
jQuery(document).ready(onReady);
jQuery(document).on('page:load', onReady);