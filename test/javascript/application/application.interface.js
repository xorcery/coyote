// require jquery
// require application.namespace

Application.Interface = function(){
	
	var Interface = this;
		
	//
	
	Interface.init = function(){
		this.forms.init();
	};
	
	//
	
	Interface.forms = {
		
		init : function(){
			this.build();
			this.style();
			this.observe();			
		},
		
		build : function(){
			
			// Add placeholder for search box
			if (!elementSupportsAttribute('input', 'placeholder')) {

				$('input[placeholder]').each(function(index) {
					var currentValue = $(this).val($(this).attr("placeholder"));
					$(this).addClass('inactive');

					$(this).focus(function() {
						if ($(this).val() == $(this).attr("placeholder")) {
							$(this).val("").removeClass('inactive');
						}
					});

					$(this).blur(function() {
						if ($(this).val() == "") {
							$(this).val($(this).attr("placeholder")).addClass('inactive');
						}
					});
				});

			}
									
		},
		
		style : function(){
			
			// Zebra stripe tables
			$("#main table tbody tr:nth-child(even)").addClass("even");
			
		},
		
		observe : function(){

		}
		
	}

	// Fire it all up
	Interface.init();
	
}