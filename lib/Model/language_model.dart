class LanguageModel{
  var id;
  var name;
  var flag;
  var language_code;
  LanguageModel({this.id,this.name,this.flag,this.language_code});

  static List<LanguageModel> language_list(){
    return <LanguageModel>[
      LanguageModel(id: 1,name: 'english',flag: '🇺🇸', language_code: 'en'),
      LanguageModel(id: 2,name: 'arabic',flag: '🇸🇦', language_code: 'ar'),
    ];
  }
}