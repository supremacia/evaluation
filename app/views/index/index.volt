{% extends "layouts/template.volt" %}
{% block content %}
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <h1 class="display-4">Dashboard</h1>
            </div>
        </div>
        
        <div class="row"><div class="col-sm-12"><hr></div></div>

        <div class="row">
            <div class="col-sm-12">
                <h2>Últimos Imóveis Cadastrados</h2>
            </div>
        </div>
        <div class="row">
            {% for imovel in imoveis %}
            <div class="col-sm-4">            
                <div class="card">
                    <img class="card-img-top" src="/media/{%if imovel.imovelimagem[0].caminho is defined %}{{ imovel.imovelimagem[0].caminho }}{% else %}default.jpg{% endif%}" alt="foto do imóvel">
                    <div class="card-body">
                        <h5 class="card-title">{{ imovel.titulo_imovel }}</h5>
                        <p class="card-text">{{ imovel.descricao }}<br /><b>{{ imovel.tipoimovel.nome }}</b>  na {{ imovel.logradouro.tipo }} {{ imovel.logradouro.nome }}, {{imovel.logradouro.bairro.nome }}</p>
                        <a href="#" class="card-link">Saiba mais</a>
                    </div>
                </div>
            </div>
            {% endfor %}
        </div>
    </div>
{% endblock %}