namespace VodSummary.Logic;

public static class VoskAccess
{
    static Model? _voskSttModel = null;

    public static async Task<string> SpeechToTextAsync(string audioPath)
    {
        // Load the model
        if (_voskSttModel is null)
            _voskSttModel = new Model(Config.VoskModelPath);

        // Create a recognizer using the model, you may need to adjust sample rate according to your audio file
        VoskRecognizer rec = new VoskRecognizer(_voskSttModel, 16000.0f);
        rec.SetMaxAlternatives(0);
        rec.SetWords(true);

        // Open your audio file
        StringBuilder sb = new StringBuilder();
        List<string> debugPartials = new();
        using (Stream source = File.OpenRead(audioPath))
        {
            byte[] buffer = new byte[4096];
            int bytesRead;

            // Process the audio file
            while ((bytesRead = await source.ReadAsync(buffer, 0, buffer.Length)) > 0)
            {
                if (rec.AcceptWaveform(buffer, bytesRead))
                    sb.AppendLine(rec.Result());
                else if (Debugger.IsAttached)
                {
                    Console.WriteLine(rec.PartialResult());
                    debugPartials.Add(rec.PartialResult());
                }                    
            }                
        }
        return sb.ToString();
    }

    private static string InterpretResult(string json)
    {
        return "";
    }
}
