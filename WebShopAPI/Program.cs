using Microsoft.EntityFrameworkCore;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddDbContext<WebShopData.Data.WebshopdbContext>(
    options =>
    {
        options.UseSqlServer(builder.Configuration.GetConnectionString("WebShopDB"));
    });

builder.Services.AddCors(options =>
{
    options.AddPolicy("MyPolicy",
        builder =>
        {
            builder.WithOrigins("http://localhost:5097",
                                "https://localhost:7001")
            .AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
        });
});




builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseCors("MyPolicy");

app.UseAuthorization();

app.MapControllers();

app.Run();
