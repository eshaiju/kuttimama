$(document).ready(function(){

	$('#close-button').click(function(){
		window.close();
	})

	$('#comment').keyup(function(){
		$( "#comment-over-image" ).text($(this).val());
	})

	$( "#comment-over-image" ).draggable(
	{
		drag:function(event,ui) {
			var wrapper = $("#image-preview").offset();
			var borderLeft = parseInt($("#image-preview").css("border-left-width"),10);
			var borderTop = parseInt($("#image-preview").css("border-top-width"),10);
			var pos = ui.helper.offset();
			$("#position-x").val(pos.left - wrapper.left - borderLeft);
			$("#position-y").val(pos.top - wrapper.top - borderTop);
		},
		containment: "parent"
	});

	$('#size').change(function(){
		var size = $('#size option:selected').val()+'px';
		console.log(size);
		$( "#comment-over-image" ).css({'font-size':size});
	})

	//Load Image
	$('#fetch-image,#fetch-image1').click(function(){
		$('#comment-image').trigger('click');
	});

	
	$('#comment-image').change(function(){
		previewImage(this)
	});
	$('#color').colpick({
		layout:'hex',
		submit:0,
		colorScheme:'dark',
		onChange:function(hsb,hex,rgb,el,bySetColor) {
			$(el).css('border-color','#'+hex);
			$( "#comment-over-image" ).css({'color':'#'+hex});
		// Fill the text box just if the color was set using the picker, and not the colpickSetColor function.
		if(!bySetColor) $(el).val(hex);
	}
	}).keyup(function(){
		$(this).colpickSetColor(this.value);
	});

	$('#generate-image').click(function(){
		$('#download-box,#replay').hide();
		var data = new FormData();
		$.each($('#comment-image')[0].files, function(i, file) {
			    data.append('image', file);
			});
		
		data.append('text',$('#comment').val());
		data.append('font_size',$('#size option:selected').val());
		data.append('color',$('#color').val());
		data.append('x',$('#position-x').val());
		data.append('y',$('#position-y').val());
		$.ajax({
			    url: '/api/v1/editor',
			    data: data,
			    cache: false,
			    dataType:'JSON',
			    contentType: false,
			    processData: false,
			    type: 'POST',
			    success: function(data){
			        $('#download').attr('href',data.image_path);
			        $('#reply').html('Successfully Completed');
			        $('#download-box,#reply').show();
			    }
			});
	})

});

// document.addEventListener('DOMContentLoaded', function(e) {
//   var closeButton = document.querySelector('#close-button');
//   closeButton.addEventListener('click', function(e) {
//     window.close();
//   });

function previewImage(input){
	$('#preview').fadeOut('fast');
	reader = new FileReader();

	reader.onload = function (e) {
		$('#preview').attr('src', e.target.result);
	};

	reader.readAsDataURL(input.files[0]);        

	$('#preview').fadeIn('slow');
}