package mon_calc.tool;

import haxe.Exception;
import mon_calc.action.MonMoveAction;
import mon_calc.action.MonSwitch;
//import sys.io.File;
import haxe.Json;
import mon_calc.action.IAction;
import mon_calc.core.BattleProcessor;
import mon_calc.entity.Battle;

//TODO : FIX SLEEP (prevent chaining endlessly)

class BattleTool {

	static var i = 0;
	
	static public function getVictoryRate( oBattle :Battle ) {
		var oRoot = new SplitNode(Root,null,null);

		// Traverse battle choice permutation tree using Breadth-first
		var lStack = new List<SplitNode>();// FIFO
		lStack.add( oRoot );

		while( ! lStack.isEmpty() ) {
			var oNode = lStack.pop();

			for( oChild in _getChildAr( oBattle, oNode ) ) {
				lStack.add( oChild );
			}

			// Ignore siblings
			var bSide = oNode.nature == Move_Blue 
						|| oNode.nature == Switch_Blue;
			if( 
				( oNode.victory_ratio == 1 && ! bSide )
				|| (oNode.victory_ratio == 0 && bSide )
			) {
				for( oChild in oNode.parent.childAr ) {
					lStack.remove( oChild );
					if( oChild.childAr.length != 0 )
						throw '!!!';
				}
			}

		}
		// File.saveContent(
		// 	'res_'+i+'.json',
		// 	Json.stringify(oRoot.getSimpleData())
		// );
	}


//_____________________________________


	static private function _getChildAr( 
		oBattle :Battle, 
		oNode :SplitNode
	) :Array<SplitNode> {

		if( oNode.victory_ratio != null ) throw '!!!';

		// Update battle
		var oPrevState = oNode.getParentState();
		var aPrevStack = oPrevState.stack;
		var oBattleCurrent = oPrevState.state == null ? 
			oBattle.copy() : oPrevState.state.copy();

		var oCurrentNode = oNode;

		var fnAction = (aAction :Array<IAction>) -> {

			// Case : start turn (RedMove)
			if( aAction[0].getSide() == false ) {
				oCurrentNode.state = oBattleCurrent.copy();
			}

			// Case : loading state
			if( aPrevStack.length != 0 ) {
				var oNodePrev = aPrevStack.shift();
				if( oNodePrev.value == null ) throw '!!!';
				return cast( oNodePrev.value, Int );
			}
			throw new ChoiceException( aAction );
		};

		// TOOD : replace action callback ?
		var oProcessor = new BattleProcessor( 
			oBattleCurrent,
			(processor, f) -> {

				// Ignore unlikely event
				if( f >= 0.9 ) return true;
				if( f <= 0.1 ) return false;

				// Case : loading state
				if( aPrevStack.length != 0 ) {
					var oNodePrev = aPrevStack.shift();
					if( oNodePrev.value == null ) throw '!!!';
					return cast( oNodePrev.value, Bool);
				}

				throw new RandException( f );
			},
			fnAction,fnAction
		);
		try {
			oProcessor.process();
		} catch( e :ChoiceException ) {
			
			var aAction = e.getChoiceAr();

			// Failsafe: no move available
			if( aAction.length == 0 ) throw '!!!';

			var childAr = [];
			for( i in 0...aAction.length ) {
				childAr.push( new SplitNode(
					( Std.isOfType(aAction[i],MonSwitch) ) ? 
						( aAction[i].getSide() ? Switch_Blue : Switch_Red ) : 
						( aAction[i].getSide() ? Move_Blue : Move_Red ), 
					oCurrentNode, i, 
					Std.isOfType(aAction[i],MonMoveAction) ? 
						untyped aAction[i].getMove( oBattleCurrent ).getLabel() : 'w/e'
				) );
			}
			oNode.childAr = childAr;
			return childAr;
		} catch( e :RandException ) {
			var f = e.getRand();
			oNode.childAr = [
				new SplitNode( Rand, oCurrentNode, true, f ),
				new SplitNode( Rand, oCurrentNode, false, 1 - f ),
			];
			return oNode.childAr;
		}
		// TODO
		var bVictor = oProcessor.getVictor();
		if( bVictor == null ) throw '!!!';

		oCurrentNode.victory_ratio = bVictor ? 0.0 : 1.0;
		var depth = oCurrentNode.getParentAr().length;
		if( depth == 8 ) {
			// File.saveContent(
			// 	'res_'+depth+'.log',
			// 	oProcessor.getLog().join('\r\n')
			// );
			throw '!!!';
		}
			
		trace((bVictor ? 'Blue' : 'Red') + ' WIN ('+depth+' node)');

		return [];

		// File.saveContent(
		// 	'battle_'+(i++)+'.log',
		// 	oProcessor.getLog().join('\r\n')
		// );

	}





//_____________________________________


	static private function _exploreNode( 
		oBattle :Battle, 
		oNode :SplitNode, 
		lExploreStack :List<SplitNode> 
	) {

		if( oNode.victory_ratio != null ) throw '!!!';

		// Update battle
		var oPrevState = oNode.getParentState();
		var aPrevStack = oPrevState.stack;
		var oBattleCurrent = oPrevState.state == null ? 
			oBattle.copy() : oPrevState.state.copy();

		var oCurrentNode = oNode;

		var fnAction = (aAction :Array<IAction>) -> {

			var i = oCurrentNode.getParentAr().length;
			if( i >= 50 )
				throw new TimeoutException('');

			// Case : start turn (RedMove)
			if( aAction[0].getSide() == false ) {
				oCurrentNode.state = oBattleCurrent.copy();
			}

			// Case : loading state
			if( aPrevStack.length != 0 ) {
				var oNodePrev = aPrevStack.shift();
				if( oNodePrev.value == null ) throw '!!!';
				return cast( oNodePrev.value, Int );
			}

			if( oCurrentNode.hasAlreadySwitched() ) {
				var aNewAction = aAction.filter((oAction :IAction) -> {
					return !Std.isOfType(aAction[i],MonSwitch);
				});
				if( aNewAction.length != 0 )
					aAction = aNewAction;
			}
			
			for( i in 0...aAction.length ) {
				oCurrentNode.childAr.push( new SplitNode(
					( Std.isOfType(aAction[i],MonSwitch) ) ? 
						( aAction[i].getSide() ? Switch_Blue : Switch_Red ) : 
						( aAction[i].getSide() ? Move_Blue : Move_Red ), 
					oCurrentNode, i, 
					Std.isOfType(aAction[i],MonMoveAction) ? 
						untyped aAction[i].getMove( oBattleCurrent ).getLabel() : 'w/e'
				) );
			}

			if( oCurrentNode.childAr.length == 0 ) throw '!!!';
			
			oCurrentNode = oCurrentNode.childAr[0];
			return 0;
		};

		
		var oProcessor = new BattleProcessor( 
			oBattleCurrent,
			(processor, f) -> {

				// Ignore unlikely event
				if( f >= 0.9 ) return true;
				if( f <= 0.1 ) return false;

				// Case : loading state
				if( aPrevStack.length != 0 ) {
					var oNodePrev = aPrevStack.shift();
					if( oNodePrev.value == null ) throw '!!!';
					return cast( oNodePrev.value, Bool);
				}

				oCurrentNode.childAr = [
					new SplitNode( Rand, oCurrentNode, true, f ),
					new SplitNode( Rand, oCurrentNode, false, 1 - f ),
				];
				oCurrentNode = oCurrentNode.childAr[0];
				
				return true;
			},
			fnAction,fnAction
		);
		try {
			oProcessor.process();
		} catch( e :TimeoutException ) {
			if( lExploreStack.filter((o) -> {
				return o == oCurrentNode;
			}).first() != null ) throw '!!!';
			// File.saveContent(
			// 	'res_'+i+'.log',
			// 	oProcessor.getLog().join('\r\n')
			// );
			oCurrentNode.victory_ratio = -1;
			_resolveNode( oCurrentNode, lExploreStack );
			return;
		}
		var bVictor = oProcessor.getVictor();
		if( bVictor == null ) throw '!!!';

		oCurrentNode.victory_ratio = bVictor ? 0.0 : 1.0;
		_resolveNode( oCurrentNode, lExploreStack );

		// File.saveContent(
		// 	'battle_'+(i++)+'.log',
		// 	oProcessor.getLog().join('\r\n')
		// );

	}

	static private function _resolveNode( oNode :SplitNode, lExploreStack :List<SplitNode> ) {
		if( oNode == null ) return;
		if( oNode.victory_ratio != null ) {
			_resolveNode( oNode.parent, lExploreStack );
			return;
		}

		trace('________');
		var s = oNode.getParentState().stack.map((oNode :SplitNode) -> {
			return Std.string( oNode.value );
		}).join(',');
		trace(s);

		for( oChild in oNode.childAr )
			trace(oChild.victory_ratio);


		if( oNode.childAr.length != 0 ){
			var oFirstChildNode = oNode.childAr[0];
			switch( oFirstChildNode.nature ) {
				case Move_Red,Move_Blue,
					Switch_Red, Switch_Blue: 

					var bSide = oFirstChildNode.nature == Move_Blue 
						|| oFirstChildNode.nature == Switch_Blue;

					trace('Solving for '+(bSide?'BLUE':'RED'));

					// Case : guaranteed win
					for( oChild in oNode.childAr ) {
						if( 
							( oChild.victory_ratio == 1 && ! bSide )
							|| (oChild.victory_ratio == 0 && bSide )
						) {
							trace('Solved color');
							oNode.victory_ratio = oChild.victory_ratio;
							_resolveNode( oNode.parent, lExploreStack );
							return;
						}
					}

					// Case : at least a child require exploring
					for( oChild in oNode.childAr ) {
						if( oChild.victory_ratio == null ) {
							lExploreStack.add( oChild );
							return;
						}
					}

					// Case : all child are explored
					oNode.victory_ratio = Lambda.fold( 
						oNode.childAr, 
						( item: SplitNode, result :Null<Float>) -> {
							if( bSide )
								return Math.min( item.victory_ratio, result);
							return Math.max( item.victory_ratio, result);
						},
						0
					);
					trace('Solved');
					_resolveNode( oNode.parent, lExploreStack );

					
					// TODO : take the best odds
				default:
			}
		}

		// Case : at least a child require exploring
		var bTimeout = false;
		for( oChild in oNode.childAr ) {
			if( oChild.victory_ratio == null ) {
				lExploreStack.add( oChild );
				return;
			}
			if( oChild.victory_ratio == -1 ) {
				bTimeout = true;
			}
		}

		if( bTimeout ){

			oNode.victory_ratio = -1;
			_resolveNode( oNode.parent, lExploreStack );
			return;
		}

		// Case : all child are explored
		oNode.victory_ratio = Lambda.fold( 
			oNode.childAr, 
			( item: SplitNode, result :Null<Float>) -> {
				return item.victory_ratio + result;
			},
			0
		) / oNode.childAr.length;
		trace('Solved');

		_resolveNode( oNode.parent, lExploreStack );
	}
}

//_____________________________________________________________________________
// 

class SplitNode {
	public var label :String;
	public var id :Int;
	public var childAr :Array<SplitNode>;
	public var parent :SplitNode;
	public var chance :Null<Float>;
	public var victory_ratio :Null<Float>;
	public var value :Dynamic;
	public var nature :ESplitNodeNature;
	public var state :Battle;

	static public var ID = 0;

	public function new( 
		nature_ :ESplitNodeNature,
		parent_ :SplitNode, 
		value_ :Dynamic, 
		chance_ :Null<Float> = null,
		label_ :String = null
	) {
		id = ID++;
		nature = nature_;
		parent = parent_;
		value = value_;
		chance = chance_;
		childAr = [];
		victory_ratio = null;
		state = null;
		label = label_;
	}

	public function hasAlreadySwitched() {
		var node = this;
		while( node.parent != null ) {
			switch( node.nature ) {
				case Move_Red,Move_Blue : return false;
				case Switch_Red,Switch_Blue : return true;
				default:
			}
			node = node.parent;
		}
		return false;
	}

	// From this (included) to root (excluded)
	public function getParentAr() {
		var a = [];
		var node = this;
		
		while( node.parent != null ) {
			a.push( node );
			node = node.parent;
		}
		return a;
	}


	// From root (excluded) to this (included)
	public function getParentState() {
		// var a = [];
		// var node = this;
		
		// while( node.parent != null && node.state == null ) {
		// 	a.push( node );
		// 	node = node.parent;
		// }
		// a.reverse();
		// return {
		// 	stack: a,
		// 	state: node.state,
		// };
		var a = [];
		var node = this;
		
		while( node.parent != null ) {
			a.push( node );
			node = node.parent;
		}
		a.reverse();
		return {
			stack: a,
			state: null,
		};
	}

	public function getSimpleData() :Dynamic {
		return {
			_id: id,
			_label: label,
			value: value,
			victory_ratio: victory_ratio,
			chance: chance,
			childAr: victory_ratio != null && victory_ratio != -1 ? 
				null : 
				childAr.map((oItem :SplitNode) -> { 
					return oItem.getSimpleData(); 
				}),
			nature: _natureToString( nature ),
			state: state != null ? 
				[
					state.getTeamRed().getMon( 0 ).getHealth(),
					state.getTeamBlue().getMon( 0 ).getHealth(),
				] : null
		};
	}

	static private function _natureToString( nature :ESplitNodeNature ) :String {
		return cast nature;
	}

	public function toString() {
		var a = [];
		var o = this;
		while( o.parent != null ) {
			a.push( o );
			o = o.parent;
		}
		
		a.reverse();

		return a.map((oNode) -> {
			return oNode.nature + oNode.value;
		}).join(' ');
	}

}


enum abstract ESplitNodeNature(String) {
	var Root; 
	var Move_Red; var Move_Blue; 
	var Switch_Red; var Switch_Blue; 
	var Rand;
}

class TimeoutException extends Exception {}
class ChoiceException extends Exception {
	var _aChoice :Array<IAction>;
	public function new( aChoice :Array<IAction> ) {
		_aChoice = aChoice;
		super('');
	}
	public function getChoiceAr() { return _aChoice; }
}
class RandException extends Exception {
	var _f :Float;
	public function new( f :Float ) {
		_f = f;
		super('');
	}
	public function getRand() { return _f; }
}
