# Gemini4Delphi
Class developed for communication between Delphi applications with Google Gemini.

# Comunicação entre Delphi e Google Gemini 
Uma classe Delphi para comunicação com a API Gemini Google AI é uma ferramenta poderosa para integrar a inteligência artificial avançada do Gemini em aplicações Delphi.

## Benefícios:
- Funcionalidades avançadas de IA: Acesso a recursos poderosos do Gemini, como compreensão de linguagem natural, tradução automática, geração de texto criativo e muito mais.
- Integração fluida: Permite que aplicações Delphi interajam diretamente com o Gemini, simplificando o desenvolvimento de funcionalidades baseadas em IA.
- Flexibilidade: A classe pode ser personalizada para atender às necessidades específicas da aplicação, tornando-se um componente versátil.

## Desafios:
- API do Gemini: O Gemini possui uma API oficial disponível publicamente. Desenvolver uma classe Delphi para comunicação com o Gemini elevará o nível das aplicações desenvolvidas com a linguagem.
- Gerenciamento de requisições: O Gemini provavelmente terá taxas de uso, o que exige o gerenciamento de requisições e otimização para evitar custos excessivos.
- Segurança e privacidade: A integração com o Gemini levanta preocupações sobre a segurança dos dados e a privacidade do usuário. 

## Considerações para a classe:
- Método de comunicação: API REST.
- Gerenciamento de autenticação e autorização: Chaves API e credenciais.
- Formatação de solicitações e respostas: Defini estruturas de dados para interagir com o Gemini.
- Tratamento de erros e exceções: Respostas inesperadas e erros de comunicação.

## Como Utilizar 
Faça download dos aquivivos e os inclua em seu projeto.

Inclua em uses a classe **UApiGemini**:
```
uses
    UApiGemini;
```

Instâcie a classe e chame os métodos Exemplo: **GenerateContent** 
```
procedure ConsomeGeminiAPI;
Var
  response : String;
  ApiGemini : TUApiGemini;
begin
  ApiGemini.FModel     := 'models/gemini-1.0-pro';
  ApiGemini.FDiscovery := 'v1beta';
  response := TratarResposta(ApiGemini.Models_GenerateContent('SEU PROMPT AQUI.'));
end;
```

Exemplo: **Models_List** 
```
procedure TuFrmPrincipal.LoadModelos;
Var
  Dados : TClientDataSet;
begin
   Dados := TClientDataSet.Create(nil);
   try
    ApiGemini.Models_List(Dados);
    while not Dados.Eof do
    begin
      comboBox.Items.Add(Dados.FieldByName('name').AsString);
      dados.Next;
    end;
   finally
     Dados.Free;
   end;
end;
```

## Documentação da API Gemini
Documentação da Api [Api Gemini](https://ai.google.dev/api/rest?hl=pt-br).


## Conclusão:
Uma classe Delphi para comunicação com o Gemini Google AI possui um grande potencial para revolucionar a maneira como as aplicações Delphi interagem com a inteligência artificial.