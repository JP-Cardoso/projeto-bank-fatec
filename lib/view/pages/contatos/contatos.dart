import 'package:flutter/material.dart';

class ListaContato extends StatefulWidget {
  final List<Contato> _contatos = [];

  ListaContato({super.key});
  @override
  State<StatefulWidget> createState() {
    return ListaContatoState();
  }
}

class ListaContatoState extends State<ListaContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView.builder(
        itemCount: widget._contatos.length,
        itemBuilder: (context, indice) {
          final contato = widget._contatos[indice];
          return ItemContato(contato);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          final Future<Contato?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioContato();
              },
            ),
          );

          future.then(
            (contatoRecebido) {
              if (contatoRecebido != null) {
                debugPrint('$contatoRecebido');
                setState(
                  () {
                    widget._contatos.add(contatoRecebido);
                  },
                );
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CadastroContatoPage extends StatelessWidget {
  const CadastroContatoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Contato'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: const Center(
        child: Text('Página de Cadastro de Contato'),
      ),
    );
  }
}

class ItemContato extends StatelessWidget {
  final Contato _contato;

  const ItemContato(this._contato, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.contacts_rounded),
        title: Text("Nome: ${_contato.nome}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Telefone: ${_contato.telefone}"),
            Text("Email: ${_contato.email}"),
            Text("Endereço: ${_contato.endereco}"),
            Text("CPF: ${_contato.cpf}")
          ],
        ),
      ),
    );
  }
}

class Contato {
  final String nome;
  final String email;
  final String cpf;
  final String endereco;
  final String telefone;

  Contato(this.nome, this.email, this.cpf, this.endereco, this.telefone);

  @override
  String toString() {
    return 'Contato(nome: $nome, cpf: $cpf, email: $email, endereco: $endereco, telefone: $telefone)';
  }
}

class FormularioContato extends StatelessWidget {
  final TextEditingController _controladorCampoNome = TextEditingController();
  final TextEditingController _controladorCampoEmail = TextEditingController();
  final TextEditingController _controladorCampoCpf = TextEditingController();
  final TextEditingController _controladorCampoEndereco =
      TextEditingController();
  final TextEditingController _controladorCampoTelefone =
      TextEditingController();

  FormularioContato({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Contato'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView(children: [
        Column(
          children: [
            Editor(
              controlador: _controladorCampoNome,
              rotulo: 'Nome',
              dica: 'Sicrano da Silva',
              icone: Icons.account_box_outlined,
            ),
            Editor(
              controlador: _controladorCampoEmail,
              rotulo: 'Email',
              dica: 'sicrano@flutter.com',
              icone: Icons.email_outlined,
            ),
            Editor(
                controlador: _controladorCampoCpf,
                rotulo: 'CPF',
                dica: '00000000000',
                icone: Icons.contact_emergency_outlined),
            Editor(
                controlador: _controladorCampoEndereco,
                rotulo: 'Endereco',
                dica: 'Rua dos Bobos, 0',
                icone: Icons.location_on),
            Editor(
                controlador: _controladorCampoTelefone,
                rotulo: 'Telefone',
                dica: '(DD) 99999-9999',
                icone: Icons.phone),
            ElevatedButton(
              child: const Text('Confirmar'),
              onPressed: () {
                _criaTransferencia(
                    context,
                    _controladorCampoNome,
                    _controladorCampoEmail,
                    _controladorCampoCpf,
                    _controladorCampoEndereco,
                    _controladorCampoTelefone);
              },
            )
          ],
        ),
      ]),
    );
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  const Editor({super.key, 
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(
          fontSize: 14.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
      ),
    );
  }
}

void _criaTransferencia(
    context,
    controladorCampoNome,
    controladorCampoEmail,
    controladorCampoCpf,
    controladorCampoEndereco,
    controladorCampoTelefone) {
  final String? nome = controladorCampoNome.text;
  final String? email = controladorCampoEmail.text;
  final String? cpf = controladorCampoCpf.text;
  final String? endereco = controladorCampoEndereco.text;
  final String? telefone = controladorCampoTelefone.text;

  if (nome != null &&
      email != null &&
      cpf != null &&
      endereco != null &&
      telefone != null) {
    final contatoCriado = Contato(nome, email, cpf, endereco, telefone);
    Navigator.pop(context, contatoCriado);
  }
}
