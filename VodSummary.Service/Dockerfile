#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:8.0-preview AS base
USER app
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0-preview AS build
WORKDIR /src
COPY ["VodSummary.Service/VodSummary.Service.csproj", "VodSummary.Service/"]
RUN dotnet restore "VodSummary.Service/VodSummary.Service.csproj"
COPY . .
WORKDIR "/src/VodSummary.Service"
RUN dotnet build "VodSummary.Service.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "VodSummary.Service.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "VodSummary.Service.dll"]