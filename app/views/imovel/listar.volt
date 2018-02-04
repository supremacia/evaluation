{% extends "layouts/template.volt" %}
{% block content %}
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <h1 class="display-4">Imóveis</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-9">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="bairro/cidade/rua ...">
                    <select name="tipo_imovel" id="tipo_imovel" class="custom-select form-control" style="max-width:120px">
                        <option value="0">Tudo</option>
                        {% for timovel in tipoimovel %}
                            <option value="{{timovel.id}}">{{timovel.nome}}</option>
                        {% endfor %}
                    </select>
                    <div class="input-group-append">
                        <button class="btn btn-success" type="button"><i class="material-icons">search</i> Buscar</button>
                    </div>
                </div>
            </div>
            
            <div class="col-sm-3">
                <a href="{{ url(['for':'site.imovel.adicionar'])}}" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="Adicionar um novo imóvel"><i class="material-icons">add</i> Adicionar</a>
            </div>
        </div>
        <div>&nbsp;</div>
        
        <div class="row">
            <div class="col-sm-12">
                <table class="table table-striped">
                    <tr>
                        <th width="1%">Código</th>
                        <th>Tipo de Imóvel</th>
                        <th width="20%" align="right">Valor do Imóvel (R$)</th>
                        <th width="160">Ações</th>
                    </tr>
                    {% for imovel in imoveis %}
                        <tr>
                            <td>{{ imovel.codigo}}</td>
                            <td>{{ imovel.tipoimovel.nome }}</td>
                            <td align="right"><?php echo number_format(($imovel->tipo_negocio == "V" ? $imovel->valor_venda : $imovel->valor_aluguel), 2, ',', '.')?></td>
                            <td>
                                <a href="{{ url(['for':'site.imovel.visualizar', 'id':imovel.id])}}" class="btn btn-light" data-toggle="tooltip" data-placement="top" title="Ver dados completos"><i class="material-icons text-success">visibility</i> </a>
                                <a href="{{ url(['for':'site.imovel.editar', 'id':imovel.id])}}" class="btn btn-light" data-toggle="tooltip" data-placement="top" title="Editar este imóvel"><i class="material-icons text-primary">create</i> </a>
                                <a href="{{ url(['for':'site.imovel.remover', 'id':imovel.id])}}" class="btn btn-light" data-toggle="tooltip" data-placement="top" title="Remover este imóvel"><i class="material-icons text-danger">delete</i> </a>
                            </td>
                        </tr>
                    {% endfor %}
                </table>
            </div>
        </div>
        
        <div class="row"><div class="col-sm-12"><hr></div></div>

        <nav aria-label="...">
            <ul class="pagination">
                <li class="page-item disabled"><span class="page-link">Previous</span></li>
                <li class="page-item active"><span class="page-link">1<span class="sr-only">(current)</span></span></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">Next</a></li>
            </ul>
        </nav>
    </div>
{% endblock %}