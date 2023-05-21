
import Foundation
import CoreLocation

var stats = StatsViewModel()

class StatsViewModel : ObservableObject {
   
    //Variáveis para a fazer update StatsView
    @Published var speed = 0.0
    @Published var duration = "00:00:00"
    @Published var avg_speed = 0.0
    @Published var distance = 0.0
    @Published var calories = 0.0
    
    /**
      Coordenadas por onde o utilizador passou
    */
    var locations : [CLLocation] = []
    
    /**
     Data de inicio de treino (Quando clica no play)
    */
    var startDate : Date = Date()
    var active : Bool = false;
    // Variáveis auxiliares
    var accumulatedSpeed = 0.0
    let formatter = DateFormatter()
    
    
    init(speed: Double = 0.0, duration: String = "00:00:00", avg_speed: Double = 0.0, distance: Double = 0.0, calories: Double = 0.0, accumulatedSpeed: Double = 0.0, locations: [CLLocation] = []) {
        self.speed = speed
        self.duration = duration
        self.avg_speed = avg_speed
        self.distance = distance
        self.calories = calories
        self.accumulatedSpeed = accumulatedSpeed
        self.locations = locations
        
        formatter.dateFormat = "HH:mm:ss"
    }
    
    
    /**
     Está função é chamada sempre que ocorre uma actualização na posição do utilizador
     O Objecto CLLocation contêm as informações relevantes sobre as coordenas geografica, altitude, heading e velocidade
    */
    func updatePosition(_ p: CLLocation){
        
        let timeElapsed = p.timestamp.timeIntervalSince(startDate)
        let currentDate = Date(timeIntervalSinceReferenceDate: timeElapsed)
        
        // adiciona a localização atual no array
        locations.append(p)
        accumulatedSpeed = accumulatedSpeed + p.speed
        
        //Actualiza o valor das variáveis
        DispatchQueue.main.async {
            self.getSpeed(speed: p.speed)
            self.getDuration(newDate: currentDate)
            self.getAvgSpeed()
            self.calcDistance()
            self.calcCalories( timeElapsed: timeElapsed )
        }
    }
    
    
    //Função chamada quando o treino é iniciado ou sai da pausa
    func startWorkout(){
        if !active {
            startDate =  Date()
            active = true;
        }
    }
    
    //Função chamada quando o treino termina
    func stopWorkout(){
        active = false
        // TODO: save data for future analysis
        cleanData()
    }
    
    //Função para colocar o treino em pausa
    func pauseWorkout(){
        
    }
    
    /**
        Função para calcular a velocidade .
        Deve actualizar a variavel speed com a nova velocidade.
        Esta função é chamada sempre que existe um update na localizacao.
        Dica: Na lista de localizacoes (var locations) os objectos têm informação sobre a velocidade com que o user passou pelo ponto
     */
    func getSpeed(speed: Double){
        self.speed = speed * getSpeedUnit()
    }
    
    /**
        Função para calcular a velocidade  média.
        Deve actualizar a variavel average_speed com a nova velocidade media.
        Esta função é chamada sempre que existe um update na localizacao.
        Dica: Na lista de localizacoes os objectos têm informação sobre a velocidade com que o user passou pelo ponto
     */
    func getAvgSpeed(){
        self.avg_speed = (self.accumulatedSpeed / Double(self.locations.count)) * getSpeedUnit()
    }
    
    /**
        Função para calcular a distância percorrida.
        Deve actualizar a variavel distance com a nova distância.
        Esta função é chamada sempre que existe um update na localizacao
        Dica: O CLLocation contêm um método .distance(from: CLLocation) que devolve a distância de uma coordenada a outra em Metros
     */
    func calcDistance(){
        // só calcula a distância quando há pelo menos duas locations
        if locations.count > 1 {
            let lastLocation = self.locations[locations.count - 1]
            let previousLocation = self.locations[locations.count - 2]
            self.distance += lastLocation.distance(from: previousLocation) / 1000
        }
        
    }
    
    /**
        Função para calcular a duracao do treino .
        Deve actualizar a variavel duration com a nova duracao.
        Esta função é chamada sempre que existe um update na localizacao.
        Dica: Na lista de localizacoes (var locations) os objectos têm informação sobre a velocidade com que o user passou pelo ponto
     */
    func getDuration(newDate: Date){
        self.duration = formatter.string(from: newDate)
        
    }
    
    /**
         Função para calcular uma estimativa das calorias gastas .
         Deve actualizar a variavel calories com a quantidade de calorias gasta.
         Esta função é chamada sempre que existe um update na localizacao.

     Consultar o website para obter a formula matemática que permite o cálculo das calorias gastas:
     https://www.hss.edu/conditions_burning-calories-with-exercise-calculating-estimated-energy-expenditure.asp
     
     Energy expenditure (calories/minute) = .0175 x MET (from table) x weight (in kilograms)
     */
    func calcCalories(timeElapsed: TimeInterval){
        // recupara peso do usuário das configurações
        let weight = profile.getWeight()
        self.calories += (0.175 * 8.0 * weight) * (timeElapsed / 3600);
       
    }
    
    /**
        Essa função retorna a taxa de conversão para Km/h de acordo com as configurações do usuário.
        O GPS retorna os dados em m/s, se não for preciso converter mantem se o mesmo valor.
     */
    func getSpeedUnit() -> Double {
        return profile.useKmH() ? 3.6 : 1
    }
    
    func cleanData(){
        self.locations = []
        DispatchQueue.main.async {
            self.distance = 0
            self.speed = 0
            self.avg_speed = 0
            self.calories = 0
            self.duration = "00:00:00"
        }
    }
    
}
