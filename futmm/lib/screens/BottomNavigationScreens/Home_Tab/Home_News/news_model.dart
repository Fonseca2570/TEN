class AppNew {
  String title;
  String content;
  String imgUrl;
  String dataPub;

  AppNew({
    this.title,
    this.content,
    this.imgUrl,
    this.dataPub,
  });
}

List<AppNew> appNews = [
  AppNew(
    title: 'Escolha do melhor campo de Janeiro',
    content: 'Perante a data de destaque da notícia, está aberto o formulário de voto para o melhor campo!',
    imgUrl: 'assets/images/news_tab/best_field.jpg',
    dataPub: '10/01/2020',
  ),
  AppNew(
    title: 'Melhor campo de Dezembro',
    content: 'Neste mês, perante alguns criticos, o campo situado na afurada foi considerado um dos melhores para praticar desporto.',
    imgUrl: 'assets/imagens/background1.jpg',
    dataPub: '10/01/2020',
  ),
  AppNew(
    title: 'Abertuda da Aplicação',
    content: 'A partir de hoje a nossa aplicação passou a estar funcional com acesso beta para ser utilizado pelos nossos utilizadores.',
    imgUrl: 'assets/images/news_tab/beta_launch.jpg',
    dataPub: '17/12/2019',
  ),
  AppNew(
    title: 'Início do desenvolvimento',
    content: 'A equipa de programação do FutMM começou hoje a desenvolver em detalhe a aplicação.',
    imgUrl: 'assets/images/news_tab/app_development.jpg',
    dataPub: '10/12/2019',
  ),
  AppNew(
    title: 'Escolha do Tema',
    content: 'O nosso tema é a criação de uma aplicação híbrida que permite fazer Matchmaking de jogos de futebol com amigos ou desconhecidos.',
    imgUrl: 'assets/imagens/brain_storming.jpg',
    dataPub: '7/12/2019',
  ),
  AppNew(
    title: 'Formação do Grupo',
    content: 'Foi formado o nosso grupo para a cadeira de TEN composta pelos alunos: João Fonseca, Ivo Ferreira, Carlos, Hugo Silva, Bruno Moura, Hugo Alves, Nuno Bandeira.',
    imgUrl: 'assets/images/news_tab/team_creation.jpg',
    dataPub: '6/12/2019',
  ),
];