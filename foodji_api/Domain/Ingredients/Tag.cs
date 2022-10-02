namespace Domain.Ingredients;

public class Tag
{
    public string Name { get; private set; }

    public static Tag Vegan { get; } = new Tag("Vegan");
    public static Tag Vegetarian { get; } = new Tag("Vegetarian");
    public static Tag GlutenFree { get; } = new Tag("GlutenFree");
    public static Tag SoyFree { get; } = new Tag("SoyFree");
    public static Tag NutFree { get; } = new Tag("NutFree");
    public static Tag PeanutFree { get; } = new Tag("PeanutFree");
    public static Tag LactoseFree { get; } = new Tag("LactoseFree");
    

    private Tag(string name)
    {
        Name = name;
    }

    public static Tag Create(string name)
    {
        return new Tag(name);
    }
}