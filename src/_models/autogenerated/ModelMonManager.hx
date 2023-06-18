// This is autogenerated file. Do not edit!

package models.autogenerated;

class ModelMonManager
{
	var db : orm.Db;
	var orm : models.Orm;
	public var query(get, never) : orm.SqlQuery<models.ModelMon>;

	function get_query() : orm.SqlQuery<models.ModelMon>
	{
		return new orm.SqlQuery<models.ModelMon>("model_mon", db, this);
	}

	public function new(db:orm.Db, orm:models.Orm) : Void
	{
		this.db = db;
		this.orm = orm;
	}

	function newModelFromParams(type:Int, ev_hp:Int, ev_att:Int, ev_def:Int, ev_mag:Int, ev_res:Int, ev_speed:Int, ability:Int, item:Int, level:Int, nature:Int, move_0:Int, move_1:Int, move_2:Int, move_3:Int) : models.ModelMon
	{
		var _obj = new models.ModelMon(db, orm);
		_obj.type = type;
		_obj.ev_hp = ev_hp;
		_obj.ev_att = ev_att;
		_obj.ev_def = ev_def;
		_obj.ev_mag = ev_mag;
		_obj.ev_res = ev_res;
		_obj.ev_speed = ev_speed;
		_obj.ability = ability;
		_obj.item = item;
		_obj.level = level;
		_obj.nature = nature;
		_obj.move_0 = move_0;
		_obj.move_1 = move_1;
		_obj.move_2 = move_2;
		_obj.move_3 = move_3;
		return _obj;
	}

	function newModelFromRow(d:Dynamic) : models.ModelMon
	{
		var _obj = new models.ModelMon(db, orm);
		_obj.type = Reflect.field(d, 'type');
		_obj.ev_hp = Reflect.field(d, 'ev_hp');
		_obj.ev_att = Reflect.field(d, 'ev_att');
		_obj.ev_def = Reflect.field(d, 'ev_def');
		_obj.ev_mag = Reflect.field(d, 'ev_mag');
		_obj.ev_res = Reflect.field(d, 'ev_res');
		_obj.ev_speed = Reflect.field(d, 'ev_speed');
		_obj.ability = Reflect.field(d, 'ability');
		_obj.item = Reflect.field(d, 'item');
		_obj.level = Reflect.field(d, 'level');
		_obj.nature = Reflect.field(d, 'nature');
		_obj.move_0 = Reflect.field(d, 'move_0');
		_obj.move_1 = Reflect.field(d, 'move_1');
		_obj.move_2 = Reflect.field(d, 'move_2');
		_obj.move_3 = Reflect.field(d, 'move_3');
		return _obj;
	}

	public function where(field:String, op:String, value:Dynamic) : orm.SqlQuery<models.ModelMon>
	{
		return query.where(field, op, value);
	}

	public function get(type:Int, ev_hp:Int, ev_att:Int, ev_def:Int, ev_mag:Int, ev_res:Int, ev_speed:Int, ability:Int, item:Int, level:Int, nature:Int, move_0:Int, move_1:Int, move_2:Int, move_3:Int) : models.ModelMon
	{
		return getBySqlOne('SELECT * FROM `model_mon` WHERE `type` = ' + db.quote(type)+ ' AND `ev_hp` = ' + db.quote(ev_hp)+ ' AND `ev_att` = ' + db.quote(ev_att)+ ' AND `ev_def` = ' + db.quote(ev_def)+ ' AND `ev_mag` = ' + db.quote(ev_mag)+ ' AND `ev_res` = ' + db.quote(ev_res)+ ' AND `ev_speed` = ' + db.quote(ev_speed)+ ' AND `ability` = ' + db.quote(ability)+ ' AND `item` = ' + db.quote(item)+ ' AND `level` = ' + db.quote(level)+ ' AND `nature` = ' + db.quote(nature)+ ' AND `move_0` = ' + db.quote(move_0)+ ' AND `move_1` = ' + db.quote(move_1)+ ' AND `move_2` = ' + db.quote(move_2)+ ' AND `move_3` = ' + db.quote(move_3));
	}

	public function create(type:Int, ev_hp:Int, ev_att:Int, ev_def:Int, ev_mag:Int, ev_res:Int, ev_speed:Int, ability:Int, item:Int, level:Int, nature:Int, move_0:Int, move_1:Int, move_2:Int, move_3:Int) : models.ModelMon
	{
		db.query('INSERT INTO `model_mon`(`type`, `ev_hp`, `ev_att`, `ev_def`, `ev_mag`, `ev_res`, `ev_speed`, `ability`, `item`, `level`, `nature`, `move_0`, `move_1`, `move_2`, `move_3`) VALUES (' + db.quote(type) + ', ' + db.quote(ev_hp) + ', ' + db.quote(ev_att) + ', ' + db.quote(ev_def) + ', ' + db.quote(ev_mag) + ', ' + db.quote(ev_res) + ', ' + db.quote(ev_speed) + ', ' + db.quote(ability) + ', ' + db.quote(item) + ', ' + db.quote(level) + ', ' + db.quote(nature) + ', ' + db.quote(move_0) + ', ' + db.quote(move_1) + ', ' + db.quote(move_2) + ', ' + db.quote(move_3) + ')');
		return newModelFromParams(type, ev_hp, ev_att, ev_def, ev_mag, ev_res, ev_speed, ability, item, level, nature, move_0, move_1, move_2, move_3);
	}

	public function createNamed(data:{ type:Int, ev_hp:Int, ev_att:Int, ev_def:Int, ev_mag:Int, ev_res:Int, ev_speed:Int, ability:Int, item:Int, level:Int, nature:Int, move_0:Int, move_1:Int, move_2:Int, move_3:Int }) : models.ModelMon
	{
		db.query('INSERT INTO `model_mon`(`type`, `ev_hp`, `ev_att`, `ev_def`, `ev_mag`, `ev_res`, `ev_speed`, `ability`, `item`, `level`, `nature`, `move_0`, `move_1`, `move_2`, `move_3`) VALUES (' + db.quote(data.type) + ', ' + db.quote(data.ev_hp) + ', ' + db.quote(data.ev_att) + ', ' + db.quote(data.ev_def) + ', ' + db.quote(data.ev_mag) + ', ' + db.quote(data.ev_res) + ', ' + db.quote(data.ev_speed) + ', ' + db.quote(data.ability) + ', ' + db.quote(data.item) + ', ' + db.quote(data.level) + ', ' + db.quote(data.nature) + ', ' + db.quote(data.move_0) + ', ' + db.quote(data.move_1) + ', ' + db.quote(data.move_2) + ', ' + db.quote(data.move_3) + ')');
		return newModelFromParams(data.type, data.ev_hp, data.ev_att, data.ev_def, data.ev_mag, data.ev_res, data.ev_speed, data.ability, data.item, data.level, data.nature, data.move_0, data.move_1, data.move_2, data.move_3);
	}

	public function createOptional(data:{ type:Int, ev_hp:Int, ev_att:Int, ev_def:Int, ev_mag:Int, ev_res:Int, ev_speed:Int, ability:Int, item:Int, level:Int, nature:Int, move_0:Int, move_1:Int, move_2:Int, move_3:Int }) : models.ModelMon
	{
		createOptionalNoReturn(data);
		return get(data.type, data.ev_hp, data.ev_att, data.ev_def, data.ev_mag, data.ev_res, data.ev_speed, data.ability, data.item, data.level, data.nature, data.move_0, data.move_1, data.move_2, data.move_3);
	}

	public function createOptionalNoReturn(data:{ type:Int, ev_hp:Int, ev_att:Int, ev_def:Int, ev_mag:Int, ev_res:Int, ev_speed:Int, ability:Int, item:Int, level:Int, nature:Int, move_0:Int, move_1:Int, move_2:Int, move_3:Int }) : Void
	{
		var fields = [];
		var values = [];
		fields.push('`type`'); values.push(db.quote(data.type));
		fields.push('`ev_hp`'); values.push(db.quote(data.ev_hp));
		fields.push('`ev_att`'); values.push(db.quote(data.ev_att));
		fields.push('`ev_def`'); values.push(db.quote(data.ev_def));
		fields.push('`ev_mag`'); values.push(db.quote(data.ev_mag));
		fields.push('`ev_res`'); values.push(db.quote(data.ev_res));
		fields.push('`ev_speed`'); values.push(db.quote(data.ev_speed));
		fields.push('`ability`'); values.push(db.quote(data.ability));
		fields.push('`item`'); values.push(db.quote(data.item));
		fields.push('`level`'); values.push(db.quote(data.level));
		fields.push('`nature`'); values.push(db.quote(data.nature));
		fields.push('`move_0`'); values.push(db.quote(data.move_0));
		fields.push('`move_1`'); values.push(db.quote(data.move_1));
		fields.push('`move_2`'); values.push(db.quote(data.move_2));
		fields.push('`move_3`'); values.push(db.quote(data.move_3));
		db.query('INSERT INTO `model_mon`(' + fields.join(", ") + ') VALUES (' + values.join(", ") + ')');
	}

	public function delete(type:Int, ev_hp:Int, ev_att:Int, ev_def:Int, ev_mag:Int, ev_res:Int, ev_speed:Int, ability:Int, item:Int, level:Int, nature:Int, move_0:Int, move_1:Int, move_2:Int, move_3:Int) : Void
	{
		db.query('DELETE FROM `model_mon` WHERE `type` = ' + db.quote(type)+ ' AND `ev_hp` = ' + db.quote(ev_hp)+ ' AND `ev_att` = ' + db.quote(ev_att)+ ' AND `ev_def` = ' + db.quote(ev_def)+ ' AND `ev_mag` = ' + db.quote(ev_mag)+ ' AND `ev_res` = ' + db.quote(ev_res)+ ' AND `ev_speed` = ' + db.quote(ev_speed)+ ' AND `ability` = ' + db.quote(ability)+ ' AND `item` = ' + db.quote(item)+ ' AND `level` = ' + db.quote(level)+ ' AND `nature` = ' + db.quote(nature)+ ' AND `move_0` = ' + db.quote(move_0)+ ' AND `move_1` = ' + db.quote(move_1)+ ' AND `move_2` = ' + db.quote(move_2)+ ' AND `move_3` = ' + db.quote(move_3) + ' LIMIT 1');
	}

	public function getAll(_order:String=null) : Array<models.ModelMon>
	{
		return getBySqlMany('SELECT * FROM `model_mon`' + (_order != null ? ' ORDER BY ' + _order : ''));
	}

	public function getBySqlOne(sql:String) : models.ModelMon
	{
		var rows = db.query(sql + ' LIMIT 1');
		if (rows.length == 0) return null;
		return newModelFromRow(rows.next());
	}

	public function getBySqlMany(sql:String) : Array<models.ModelMon>
	{
		var rows = db.query(sql);
		var list : Array<models.ModelMon> = [];
		for (row in rows)
		{
			list.push(newModelFromRow(row));
		}
		return list;
	}
}