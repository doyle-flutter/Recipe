// 처음
TextButton(
  child: Text("POP-UP\n-Alert + PageMove"),
  onPressed: (){
     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("POP-UP"),
        actions: [
          TextButton(
            child: Text("닫기"),
            onPressed: (){},
          )
        ],
      )
    );
  },
)

// 중간
TextButton(
  child: Text("POP-UP\n-Alert + PageMove"),
  onPressed: () async{
     bool result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("POP-UP"),
        actions: [
          TextButton(
            child: Text("닫기"),
            onPressed: () => Navigator.of(context).pop(false),
          )
        ],
      )
    );
    print(result);
  },
)

// 최종
TextButton(
  child: Text("POP-UP\n-Alert + PageMove"),
  onPressed: () async{
    bool result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("POP-UP"),
        actions: [
          TextButton(
            child: Text("닫기"),
            onPressed: () => Navigator.of(context).pop(false),
          )
        ],
      )
    ) ?? false;
    print(result);
    if(!result) return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => new Scaffold(
          appBar: AppBar(title: Text("Hi POP-UP ?!"),),
        )
      )
    );
  },
)
