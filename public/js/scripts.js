var TMP;
var IMG = {name:'',url:'',action:'delete'}; //upload data object

$(document).ready(function(){


	if("undefined" !== typeof $().chosen){
	 	$(".chosen-select").chosen({no_results_text: "Inválido: "});
	}

	$('[data-toggle="tooltip"]').tooltip();

	 //Mostra/escnde a caixa de data quando escolher publicar
	$('#publicado').on('click', function(e){
	 	if(e.target.checked) {
	 		$('#data_control').removeClass('hide');
	 	} else {
	 		$('#data_control').addClass('hide');
	 	}
	})

	//Para faze o upload/delete da imagem
	if("undefined" !== typeof $('#imagem')[0]){
		 $('#imagem').fileupload({
	        dataType: 'json',
	        add: function (e, data) {
	        	$('#img1').hide();
				data.url = UPIMGURL;

				console.log(data);
				TMP = data;

				if(    data.files[0].type == 'image/png'
			    	|| data.files[0].type == 'image/jpg'
			    	|| data.files[0].type == 'image/jpeg')
			    {
			    	data.submit();
			    } else {
			    	data.form.val('');
			    	$('#realimagem').val('');
	    			return alert("Escolha uma imagem \".jpg\", \".jpeg\" ou \".png\"");
			    }
			},
			done: function (e, data) { TMP = data;
				if("undefined" !== typeof data.result.imagem){
					$('#img1 > img').attr('src',data.result.imagem.imagem)
					$('#realimagem').val(data.result.imagem.imagem);//data.result.imagem.url);
					$('#img1').show();
					$('#imgcontaner').hide();
					IMG = data.result.imagem;
				}
	        }
	    });

		//Mask to "Real" currency
		$("#valor").inputmask('decimal', {
                'alias': 'numeric',
                'groupSeparator': '.',
                'autoGroup': true,
                'digits': 2,
                'radixPoint': ",",
                'digitsOptional': false,
                'allowMinus': false,
                'prefix': '',
                'placeholder': ''
    	});

		//datapicker setup for pt-Br
    	$('#data_expiracao').datepicker({
		   dateFormat: 'dd/mm/yy',
		   dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
		   dayNamesMin: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S', 'D'],
		   dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
		   monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
		   monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
		   nextText: 'Proximo',
		   prevText: 'Anterior',
		   minDate: 0
		});
		var d = new Date;
		$('#data_expiracao').datepicker( "setDate", d.toLocaleString().split(' ')[0] );
	}


	//Intercept form submit event
	$("#formImovel").submit(function(e){
    	e.preventDefault();

    	var data = {};

    	//Código
    	if($('#codigo').val() == '') {
    		$('#codigo').focus();
    		showPopover('codigo', 'Código inválido!', 'É necessário insirir um código.');
    		return false;
    	}

    	//Número
    	if($('#numero').val() == '') {
    		$('#numero').focus();
    		showPopover('numero', 'Faltando', 'É necessário insirir o número do imóvel.');
    		return false;
    	}

    	//Valor
    	if($('#valor').val() == '') {
    		$('#valor').focus();
    		showPopover('valor', 'Nenhum valor?', 'Informe um valor para esse imóvel.');
    		return false;
    	}

    	//imagem
    	if($('#realimagem').val() == '') {
    		$('#imagem').focus();
    		showPopover('imagem', 'Sem imagem?', 'Escolha uma imagem bem bonita para este imóvel!');
    		return false;
    	}

    	//Título da publicação
    	if($('#titulo_imovel').val() == '') {
    		$('#titulo_imovel').focus();
    		showPopover('titulo_imovel', 'Título', 'Digite um texto bem interessante para a sua publicação!');
    		return false;
    	}

    	//Descrição da publicação
    	if($('#descricao').val() == '') {
    		$('#descricao').focus();
    		showPopover('descricao', 'Descrição faltando!', 'Coloque informaçãoes detalhadas para não deixar dúvidas nos leitores da postagem!');
    		return false;
    	}
 	   	

 	   	//Send to server...
    	$.post(URLSAVE, $("#formImovel").serialize())
    	 .done(function(data){

    	 	if("undefined" !== typeof data.status){
    	 		if(data.status == 'success'){
    	 			showModal('Sucesso!', 'A publicação foi salva com sucesso.', 'Ok',null, null, null, true, function(e){document.location = URLLIST}); 	 		
    	 			return true;
    	 		}

    	 		if("undefined" !== typeof data.error && data.campo !== 'all'){
    	 			showPopover(data.campo, 'Inválido', data.error);
    	 			return false;
    	 		}
    	 	}

    	 	showModal('Tivemos um problema!', 'A publicação não pode ser salva<br>Procure ajuda do administrador do sistema.', 'Ok',null, null, null, true, function(e){document.location = URLLIST});
    	 })	

	});

})

//Checa se o código é válido
function verificaCodigo(e){

	$.post(URLVALCOD, {codigo: e.value})
	 .done(function(data){
	 	if("undefined" !== data.status && data.status == 'success'){
	 		return;
	 	}
	 	showPopover('codigo','Código inválido!','Este código já está sendo usado por outro imóvel. Tente outro!');
	 })
}

//Deletar a imagem...
function deleteImg(){
	IMG.action = 'delete';
	
	$('#img1 > img').attr('src','')
	$('#realimagem').val('');
	$('#img1').hide();
	$('#imgcontaner').show()
	$('#imagem').focus();
}



//PopOver
function showPopover(e, title, content, time){
	var title = title || 'Inválido!';
	var content = content || 'Tente modificar...';
	var time = time || 3000;

	$('#'+e).popover({
	 		trigger: 'manual',
	 		placement: 'bottom',
	 		title: title,
	 		content: content
	 	})
	 	$('#'+e).popover('show').val('');
	 	setTimeout(function(){$('#'+e).popover('hide')},time);
}


//Cancelar
function cancelar(){
	document.location = URLLIST;
}


function showModal(title, content, closeTxt, goTxt, closeFunction, goFunction, locked, hideCalback){

	title = title || 'Título';
	content = content || 'Mensagem';
	closeTxt = closeTxt || false;
	goTxt = goTxt || false;
	closeFunction = closeFunction || false;
	goFunction = goFunction || false;
	locked = locked || false;

	if(closeFunction) closeFunction += '()';
	if(goFunction) goFunction += '()';
	locked = locked !== false ? 'static' : true;


	var m = document.getElementById('jsmodal');
	if(!m){
		m = document.createElement('DIV');
		m.id = 'jsmodal';
		document.body.appendChild(m);
	}

	m.innerHTML = '<div class="modal fade" id="jsmodalmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">'
				 +'<div class="modal-dialog" role="document">'
				 +'<div class="modal-content">'
				 +'<div class="modal-header">'
				 +'<h5 class="modal-title" id="jsModalLabel">'+title+'</h5>'
				 +'<button type="button" class="close" data-dismiss="modal" aria-label="Close">'
				 +'<span aria-hidden="true">&times;</span>'
				 +'</button>'
				 +'</div>'
				 +'<div class="modal-body">'
				 +content
				 +'</div>'
				 +'<div class="modal-footer">'
				 +(closeTxt ? '<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="'+closeFunction+'">'+closeTxt+'</button>' : '')
				 +(goTxt ? '<button type="button" class="btn btn-primary" onclick="'+goFunction+'">'+goTxt+'</button>' : '')
				 +'</div>'
				 +'</div>'
				 +'</div>'
				 +'</div>';
	
	$('#jsmodalmodal').modal({keyboard: false, backdrop: locked, show: true});
	$('#jsmodalmodal').on('hidden.bs.modal', hideCalback ) 
}