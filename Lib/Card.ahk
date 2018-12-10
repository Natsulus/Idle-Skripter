class Card
{
	name := ""
	zone := ""
	bonusType := ""
	initialBonus := ""
	finalBonus := ""
	position := {}

	__New(name, zone, bonustype, initialBonus, finalBonus, position)
	{
		this.name := name
		this.zone := zone
		this.bonusType := bonusType
		this.initialBonus := initialBonus
		this.finalBonus := finalBonus
		this.position := position
	}
}