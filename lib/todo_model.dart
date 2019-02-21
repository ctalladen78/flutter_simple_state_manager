class TodoItem{  
      String objectId;
      String data;
      String createdAt;
      String updatedAt; 
    
      TodoItem({ 
        this.objectId,this.data,this.createdAt,this.updatedAt,
      });
      
      static TodoItem fromJson(Map<String,dynamic> json){
        return TodoItem( 
            objectId: json['objectId'],
            data: json['data'],
            createdAt: json['createdAt'],
            updatedAt: json['updatedAt'],
        );
      }
      
      Map<String, dynamic> toJson() => { 
            'objectId': objectId,
            'data': data,
            'createdAt': createdAt,
            'updatedAt': updatedAt,
      };
    }