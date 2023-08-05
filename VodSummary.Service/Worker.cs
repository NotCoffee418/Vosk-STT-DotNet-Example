using System.Reflection;
using VodSummary.Logic;
using VodSummary.Logic.Data;

namespace VodSummary.Service;

public class Worker : BackgroundService
{
    private readonly ILogger<Worker> _logger;

    public Worker(ILogger<Worker> logger)
    {
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        
        while (!stoppingToken.IsCancellationRequested)
        {
            if (_logger.IsEnabled(LogLevel.Information))
            {
                _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
            }


            string filePath = Path.Join(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "test-stt.wav");
            string aa = await VoskAccess.SpeechToTextAsync(filePath);
            Console.WriteLine(aa);


             

            await Task.Delay(1000, stoppingToken);
        }
    }
}