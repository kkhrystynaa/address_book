use anyhow::{anyhow, Result};
use pest::Parser;
use pest_derive::Parser;

#[derive(Parser)]
#[grammar = "./grammar.pest"]
pub struct Grammar;

fn parse_phone_numbers(input: &str) -> Result<()> {
    let pairs = Grammar::parse(Rule::fields, input).map_err(|e| anyhow!("Parsing error: {}", e))?;
    for pair in pairs {
        println!("Parsed: {:?}", pair);
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_single_phone_number() {
        let input = "123-456-7890";
        let result = parse_phone_numbers(input);
        assert!(result.is_ok(), "Expected successful parsing for single phone number");
    }

    #[test]
    fn test_parse_multiple_phone_numbers() {
        let input = "123-456-7890, 555-123-4567";
        let result = parse_phone_numbers(input);
        assert!(result.is_ok(), "Expected successful parsing for multiple phone numbers");
    }
}