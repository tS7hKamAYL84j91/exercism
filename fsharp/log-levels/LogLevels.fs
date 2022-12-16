module LogLevels

open System.Text.RegularExpressions

let logMatch logline = 
      Regex.Match(logline, @"\[(?<level>\w+)\]:\s*(?<message>.*)")
      |> fun rslt -> if rslt.Success then Some(rslt.Groups.["level"].Value, rslt.Groups["message"].Value) else None

let message (logLine: string): string = 
  logMatch logLine |> Option.map snd |> Option.defaultValue "" |> fun s -> s.Trim()

let logLevel(logLine: string): string = 
  logMatch logLine |> Option.map fst |> Option.defaultValue "" |> fun s -> s.ToLower()

let reformat(logLine: string): string = $"{message logLine} ({logLevel logLine})"
