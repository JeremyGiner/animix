// This is autogenerated file. Do not edit!

package models.autogenerated;

class ModelMoveManager
{
	var db : orm.Db;
	var orm : models.Orm;
	public var query(get, never) : orm.SqlQuery<models.ModelMove>;

	function get_query() : orm.SqlQuery<models.ModelMove>
	{
		return new orm.SqlQuery<models.ModelMove>("model_move", db, this);
	}

	public function new(db:orm.Db, orm:models.Orm) : Void
	{
		this.db = db;
		this.orm = orm;
	}

	function newModelFromParams(id:Int, key:String) : models.ModelMove
	{
		var _obj = new models.ModelMove(db, orm);
		_obj.id = id;
		_obj.key = key;
		return _obj;
	}

	function newModelFromRow(d:Dynamic) : models.ModelMove
	{
		var _obj = new models.ModelMove(db, orm);
		_obj.id = Reflect.field(d, 'id');
		_obj.key = Reflect.field(d, 'key');
		return _obj;
	}

	public function where(field:String, op:String, value:Dynamic) : orm.SqlQuery<models.ModelMove>
	{
		return query.where(field, op, value);
	}

	public function get(id:Int) : models.ModelMove
	{
		return getBySqlOne('SELECT * FROM `model_move` WHERE `id` = ' + db.quote(id));
	}

	public function create(key:String) : models.ModelMove
	{
		db.query('INSERT INTO `model_move`(`key`) VALUES (' + db.quote(key) + ')');
		return newModelFromParams(db.lastInsertId(), key);
	}

	public function createNamed(data:{ key:String }) : models.ModelMove
	{
		db.query('INSERT INTO `model_move`(`key`) VALUES (' + db.quote(data.key) + ')');
		return newModelFromParams(db.lastInsertId(), data.key);
	}

	public function createOptional(data:{ ?key:String }) : models.ModelMove
	{
		createOptionalNoReturn(data);
		return get(db.lastInsertId());
	}

	public function createOptionalNoReturn(data:{ ?key:String }) : Void
	{
		var fields = [];
		var values = [];
		if (Reflect.hasField(data, 'key')) { fields.push('`key`'); values.push(db.quote(data.key)); }
		db.query('INSERT INTO `model_move`(' + fields.join(", ") + ') VALUES (' + values.join(", ") + ')');
	}

	public function delete(id:Int) : Void
	{
		db.query('DELETE FROM `model_move` WHERE `id` = ' + db.quote(id) + ' LIMIT 1');
	}

	public function getAll(_order:String=null) : Array<models.ModelMove>
	{
		return getBySqlMany('SELECT * FROM `model_move`' + (_order != null ? ' ORDER BY ' + _order : ''));
	}

	public function getBySqlOne(sql:String) : models.ModelMove
	{
		var rows = db.query(sql + ' LIMIT 1');
		if (rows.length == 0) return null;
		return newModelFromRow(rows.next());
	}

	public function getBySqlMany(sql:String) : Array<models.ModelMove>
	{
		var rows = db.query(sql);
		var list : Array<models.ModelMove> = [];
		for (row in rows)
		{
			list.push(newModelFromRow(row));
		}
		return list;
	}
}