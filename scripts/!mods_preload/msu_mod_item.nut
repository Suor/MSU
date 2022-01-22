local gt = this.getroottable();

gt.MSU.modItem <- function ()
{
	gt.Const.Items.addNewItemType <- function( _itemType )
	{
		if (_itemType in this.Const.Items.ItemType)
		{
			this.logError("addNewItemType: \'" + _itemType + "\' already exists.");
			return;
		}

		local max = 0;
		foreach (w, value in this.Const.Items.ItemType)
		{
			if (value > max)
			{
				max = value;
			}
		}
		this.Const.Items.ItemType[_itemType] <- max << 1;
	}

	::mods_hookBaseClass("items/item", function(o) {
		local child = o;
		o = o[o.SuperName];

		o.addItemType <- function ( _t )
		{
			this.m.ItemType = this.m.ItemType | _t;
		}

		o.setItemType <- function( _t )
		{
			this.m.ItemType = _t;
		}

		o.removeItemType <- function( _t )
		{
			if (this.isItemType(_t))
			{
				this.m.ItemType -= _t;		
			}
		}

		local addSkill = o.addSkill;
		o.addSkill = function( _skill )
		{
			if (_skill.isType(this.Const.SkillType.Active) && ("FatigueOnSkillUse" in child.m))
			{
				_skill.setFatigueCost(this.Math.max(0, _skill.getFatigueCostRaw() + this.m.FatigueOnSkillUse));
			}

			addSkill(_skill);
		}

		o.onAfterUpdateProperties <- function( _properties )
		{			
		}
	});
}
