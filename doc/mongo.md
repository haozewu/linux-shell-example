在下面的这个例子中，使用mongoimport命令将文件contacts.json中的内容导入user数据库的contacts的数据表中。

> mongoimport --db users --collection contacts --file contacts.json

导入数据一句命令即可

mongoimport --db network1 --collection networkmanagement --type csv --headerline --ignoreBlanks --file /home/erik/Documents/networkmanagement-1.csv
1
--db network1：需要将数据导入到哪个数据库，这里以networ1数据库为例； 
--collection networkmanagement：将数据导入的 collection 名，这里以networkmanagement为例，如果这个networkmanagement之前是不存在的，则会自动创建一个。如果省略--collection networkmanagement这个参数，那么会自动新建一个以 CSV 文件名为名的 collection。 
--type csv：文件类型，这里是 csv； 
--headerline：这个参数很重要，加上这个参数后创建完成后的内容会以 CSV 第一行的内容为字段名； 
--ignoreBlanks：这个参数可以忽略掉 CSV 文件中的空缺值； 
--file /home/erik/Documents/networkmanagement-1.csv：这里就是 csv 文件的路径了。


mongoexport -d goods -c students --csv -f classid,name,age -o students_csv.dat  

mongoDB删除表中一个字段
使用update命令

update命令

findAndModify只会更新一个, update可以批量更新

db.getCollection('cuishou_user').update(
        {'id':{$in:[1,2,3,10,12,13]}}, //query
        {$set:{'contract_status': NumberInt(1)}},// update 
        {multi:true,upsert:false} // 批量更新
        )

update命令格式：

db.collection.update(criteria,objNew,upsert,multi)

    参数说明：

    criteria：查询条件

    objNew：update对象和一些更新操作符

    upsert：如果不存在update的记录，是否插入objNew这个新的文档，true为插入，默认为false，不插入。

    multi：默认是false，只更新找到的第一条记录。如果为true，把按条件查询出来的记录全部更新。

    //例如要把User表中address字段删除
    db.User.update({},{$unset:{'address':''}},false, true)

