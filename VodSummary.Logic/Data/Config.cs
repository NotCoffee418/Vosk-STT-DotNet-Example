using Sprache;

namespace VodSummary.Logic.Data;

public static class Config
{
    static Config()
    {
        string envPath = Path.Join(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), ".env");
        using (var stream = File.OpenRead(envPath))
        {
            DotNetEnv.Env.Load(envPath);            
        }
    }

    public static string VoskModelPath
    {
        get
        {
            string val = Environment.GetEnvironmentVariable("VoskModelPath");
            if (string.IsNullOrEmpty(val))
                val = "/app/vosk-model";
            return val;
        }
    }

}