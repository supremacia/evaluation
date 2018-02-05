{% extends "layouts/template.volt" %}
{% block content %}
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <h1 class="display-4">Adicionar <smal class="text-muted">Imovel</smal></h1>
            </div>
        </div>
        
        <form class="was-validated" id="formImovel">
            <div class="row"><div class="col-sm-12"><hr></div></div>
            <div class="row">
                <div class="col-sm-12 mb-4">
                    <h3>Dados Básicos</h3>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group col-sm-2">
                    <label for="codigo">Código</label>
                    <input name="codigo" id="codigo" type="text" onchange="verificaCodigo(this)" class="form-control" aria-describedby="codigo" placeholder="Código" maxlength="10">
                    <small id="codigo" class="form-text text-muted">Digite um código válido.</small>
                </div>
                
                <div class="form-group col-sm-3">
                    <label for="tipo_imovel">Tipo de Imóvel</label>
                    <select name="tipo_imovel" id="tipo_imovel" class="chosen-select form-control">
                        {% for timovel in tipoimovel %}
                            <option value="{{timovel.id}}">{{timovel.nome}}</option>
                        {% endfor %}
                    </select>
                </div>
                <div class="form-group col-sm-7">
                    <label for="filial">Filial</label>
                    <select name="filial" id="filial" class="chosen-select form-control">
                        {% for filial in filiais %}
                            <option value="{{filial.id}}">{{filial.nome}}</option>
                        {% endfor %}
                    </select>
                </div>
            </div>

            <div class="row"><div class="col-sm-12"><hr></div></div>
            <div class="row">
                <div class="col-sm-12 mb-4">
                    <h3>Localização</h3>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-lg-10">
                    <label for="logradouro">Logradouro</label>
                    <select name="logradouro" id="logradouro" class="chosen-select form-control">
                        {% for logradouro in logradouros %}
                            <option value="{{logradouro.id}}">{{logradouro.bairro.nome}} - {{logradouro.tipo}} {{logradouro.nome}}</option>
                        {% endfor %}
                    </select>
                </div>
                <div class="form-group col-3">
                    <label for="numero">Número</label>
                    <input name="numero" id="numero" type="number" min="1" class="form-control">
                </div>
            </div>

            <div class="row"><div class="col-sm-12"><hr></div></div>
            <div class="row">
                <div class="col-sm-12 mb-4">
                    <h3>Valor</h3>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-sm-6">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="inputGroupPrepend3">R$</span>
                        </div>
                        <input name="valor" id="valor" type="text" min="1" class="form-control">
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-sm-4">
                    <div class="custom-control custom-radio">
                        <input type="radio" id="tipo_negocio1" name="tipo_negocio" class="custom-control-input" value="A" checked="checked">
                        <label class="custom-control-label" for="tipo_negocio1">Imóvel para <b>Aluguel</b></label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input type="radio" id="tipo_negocio2" name="tipo_negocio" class="custom-control-input" value="V">
                        <label class="custom-control-label" for="tipo_negocio2">Imóvel para <b>Venda</b></label>
                    </div>
                </div>
            </div>

            <div class="row"><div class="col-sm-12"><hr></div></div>
            <div class="row">
                <div class="col-sm-12 mb-4">
                    <h3>Imagem</h3>
                </div>
            </div>

            <div class="form-group">
                <label for="imagem">Escolha uma foto</label>
                <div id="img1">
                    <img src=""/>
                    <button type="button" class="btn btn-danger" onclick="return deleteImg()"><i class="material-icons">delete</i> Apagar esta image</button>
                    <input name="realimagem" id="realimagem" type="hidden" value="">
                </div>
                <div id="imgcontaner">
                    <input type="file" name="imagem" class="form-control-file" id="imagem" aria-describedby="dimagem" accept=".jpg,.jpeg,.png">
                    <small id="dimagem" class="form-text text-muted">Escolha uma imagem no formato jpg, jpeg ou png.</small>
                </div>
            </div>

            <div class="row"><div class="col-sm-12"><hr></div></div>
            <div class="row">
                <div class="col-sm-12 mb-4">
                    <h3>Detalhes</h3>
                </div>
            </div>

            <div class="form-row">                
                <div class="form-group col-sm-4">
                    <label for="area_terreno">Área do Terreno</label>
                    <div class="input-group mb-2">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="inputGroupPrepend3">m2</span>
                        </div>
                        <input name="area_terreno" id="area_terreno" type="number" min="0" class="form-control" value="0">
                    </div>
                </div>
                <div class="form-group col-sm-2">
                    <label for="banheiros">Banheiros</label>
                    <input name="banheiros" id="banheiros" type="number" min="0" class="form-control" value="0">                    
                </div>
                <div class="form-group col-sm-4">
                    <label for="vagas_garagem">Vagas de Garagem</label>
                    <input name="vagas_garagem" id="vagas_garagem" type="number" min="0" class="form-control" value="0">                    
                </div>
                <div class="form-group col-sm-2">
                    <label for="dormitorios">Quartos</label>
                    <input name="dormitorios" id="dormitorios" type="number" min="0" class="form-control" value="0">                    
                </div>
            </div>


            <div class="row"><div class="col-sm-12"><hr></div></div>
            <div class="row">
                <div class="col-sm-12 mb-4">
                    <h3>Publicação</h3>
                </div>
            </div>

            <div class="form-row">                
                <div class="form-group col-sm-12">
                    <label for="titulo_imovel">Titulo da Publicação</label>
                    <input name="titulo_imovel" id="titulo_imovel" type="text" class="form-control" placeholder="Digite um bom título para a publicação...">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-sm-12">
                    <label for="descricao">Descrição</label>
                    <textarea name="descricao" id="descricao" class="form-control"></textarea>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-sm-6">
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="publicado" name="publicado">
                        <label class="custom-control-label" for="publicado">Publicar este imóvel <b>imediatamente</b>.</label>
                    </div>                 
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-sm-12 row hide" id="data_control">
                    <label for="data_expiracao" class="col-sm-9 col-form-label">Indique a data de expiração da publicação:</label>
                    <div class="col-sm-3">
                        <input name="data_expiracao" id="data_expiracao" type="text" class="form-control text-right" readonly="readonly">
                    </div>                    
                </div>
            </div>


            <!-- Control Buttons -->
            <div class="row"><div class="col-sm-12 mb-4"><hr></div></div>
            <div class="row">
                <div class="form-group  col-sm-12 mb-4">
                    <button type="button" onclick="return cancelar()" class="btn btn-primary"><i class="material-icons">arrow_back</i> Cancelar</button>
                    <button type="submit" class="btn btn-success"><i class="material-icons">cloud_upload</i> Salvar</button>
                </div>
            </div>
            
        </form>


    </div>
{% endblock %}