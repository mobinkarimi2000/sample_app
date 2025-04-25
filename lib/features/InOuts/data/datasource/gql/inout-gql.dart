const String gqlInout = r'''
query inout($id:Int=4){
  inout(id:$id)
  {
    id
    date
    amount  
    recPayAmount
    description
    type
    customerRef
    subRef
    currencyRef,
    currencyRatioD,
    currencyRatioM,
    Customer {
      name
      id
    }
    Category
    {
      name
      id
    }
  }
}''';

const String gqlInoutCreate = r'''
mutation inoutCreate($subRef:Int=7302,$customerRef:Int=1,$date :DateTime2="2022-01-01",$type:Boolean=true,
$description:String="",$amount:Float=0) {
   inoutCreate(newInOutData:{amount:$amount,description:$description,type:$type,
 date:$date,subRef:$subRef,customerRef:$customerRef})
  {
    id
    date
    amount  
    description
    type
    customerRef
    subRef
    Customer {
      name
      id
    }
    Category
    {
      name
      id
    }
  }
}
''';

const String gqlInoutUpdate = r'''
mutation inoutUpdate($id:Int=0,$subRef:Int=7302,$customerRef:Int=1,$date :DateTime2="2022-01-01",$type:Boolean=true,
$description:String="",$amount:Float=0) {
   inoutUpdate(updateInOutData:{id:$id,amount:$amount,description:$description,type:$type,
 subRef:$subRef,customerRef:$customerRef,date:$date})
  {
    id
    date
    amount  
    description
    type
    customerRef
    subRef
    Customer {
      name
      id
    }
    Category
    {
      name
      id
    }
  }
}
''';

const String gqlInoutRemove = r'''
mutation inoutRemove($id:Int=0) {
   inoutRemove(id:$id)
  {
    id
    date
    amount  
    description
    type
    customerRef
    subRef
  }
}
''';
