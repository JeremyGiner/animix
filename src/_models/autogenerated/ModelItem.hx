// This is autogenerated file. Do not edit!

package models.autogenerated;

class ModelItem
{
	var db : orm.Db;
	var orm : models.Orm;
	public var id : Int;
	public var key : String;

	public function new(db:orm.Db, orm:models.Orm) : Void
	{
		this.db = db;
		this.orm = orm;
	}

	public function set(key:String) : Void
	{
		this.key = key;
	}

	public function save() : Void
	{
		db.query(
			 'UPDATE `model_item` SET '
				+  '`key` = ' + db.quote(key)
			+' WHERE `id` = ' + db.quote(id)
			+' LIMIT 1'
		);
	}
}