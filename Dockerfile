# Етап 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Копіюємо всі файли проєкту в контейнер
COPY *.sln .
COPY ./ ./

# Відновлюємо залежності
RUN dotnet restore

# Білдимо програму
RUN dotnet publish -c Release -o /out

# Етап 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Копіюємо білд з першого етапу
COPY --from=build /out .

# Виставляємо порт, на якому додаток буде працювати
EXPOSE 5000

# Запуск додатку
ENTRYPOINT ["dotnet", "CopilotStudioClient.dll"]
