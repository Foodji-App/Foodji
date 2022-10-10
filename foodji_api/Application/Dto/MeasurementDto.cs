namespace Application.Dto;

public record MeasurementDto
{
    public string? AlternativeText { get; set; } = String.Empty;

    public decimal? Value { get; set; } = 0;

    public string? UnitType { get; set; } = "unit";
}