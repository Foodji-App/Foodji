namespace FoodjiApi.DbRepresentations.Recipes;

public enum UnitType
{
    // As in "one banana" - avoid adding additional arbitrary measures as much as possible, they are not uniform.
    // "A can" can be entirely different from one area to another, from a year to another (e.g. shrinkflation), etc.
    // TODO - have a tooltip to discourage such use on the front end whenever possible
    Unit,
    Cup,
    TeaSpoon,
    TableSpoon,
    Millilitre,
    Gram,
    FluidOunce,
    Ounce,
}