# Етап 1: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Копіюємо всі необхідні файли до контейнера
COPY *.sln .
COPY ./ ./

# Відновлюємо залежності
RUN dotnet restore

# Білдимо програму
RUN dotnet publish -c Release -o /out

# Етап 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

# Копіюємо білд до другого контейнера
COPY --from=build /out .

# Виставляємо порт для додатку
EXPOSE 5000

# Запускаємо сервер
ENTRYPOINT ["dotnet", "CopilotStudioClient.dll"]
