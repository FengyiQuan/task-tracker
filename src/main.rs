mod api;
mod model;
mod repository;

use api::task::{ get_task, submit_task, start_task, complete_task, pause_task, fail_task };
use repository::ddb::DDBRepository;
use actix_web::{ get, HttpServer, App, web::Data, middleware::Logger, Responder, HttpResponse };

//create a function that returns a 200 status code
#[get("/")]
async fn home() -> impl Responder {
    HttpResponse::Ok().body("Welcome to the Task Service!")
}

//create a function that returns a 200 status code
#[get("/health")]
async fn health() -> impl Responder {
    HttpResponse::Ok()
}

//create a function that returns the version of the service
#[get("/version")]
async fn version() -> impl Responder {
    //print the version of the service
    println!("Version: {}", env!("CARGO_PKG_VERSION"));
    HttpResponse::Ok().body(env!("CARGO_PKG_VERSION"))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "debug");
    std::env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    let config = aws_config::load_from_env().await;
    HttpServer::new(move || {
        let ddb_repo: DDBRepository = DDBRepository::init(String::from("task"), config.clone());
        let ddb_data = Data::new(ddb_repo);
        let logger = Logger::default();
        App::new()
            .wrap(logger)
            .app_data(ddb_data)
            .service(home)
            .service(get_task)
            .service(submit_task)
            .service(start_task)
            .service(complete_task)
            .service(pause_task)
            .service(fail_task)
            .service(health)
            .service(version)
    })
        .bind(("127.0.0.1", 8080))?
        .run().await
}