namespace Application.Dto;

public record MeasurementDto
{
    public string? AlternativeText { get; set; }

    public decimal? Value { get; set; }

    public string? UnitType { get; set; }
}