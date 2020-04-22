type country_id = string

type borders = {
  dry: int;
  sea: int;
  air: int;
}

type country = {
  id: country_id;
  temperature: int;
  health_care: int;
  density: int;
  connectivity: borders
}