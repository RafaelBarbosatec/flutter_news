
class DateUtil{

  var mouths =['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];

  String buildDate(String date){

    try{
      var datatime = DateTime.parse(date);
      return "${datatime.day} de ${mouths[datatime.month-1]} de ${datatime.year} às ${datatime.hour}:${datatime.minute}";
    }catch(e){
      return "";
    }

  }

}