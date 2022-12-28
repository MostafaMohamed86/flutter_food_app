enum LanguageType{ENGLISH,ARABIC}

const String ARABIC = "ar";
const String ENGLISH = "en";

extension LanguageTypeExtension on LanguageType{
  String onValue(){
    switch(this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC; 
    }
  
    }
}