//
//  Movie.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit

struct Movie {
	let title: String
	let overview: String
	let genres: [String]?
}

final class MovieModel
{
	private var movie: Movie?

	func getMovie() -> Movie {
		guard let movie = self.movie else {
			return Movie(title: "-", overview: "-", genres: ["-"])
		}
		return movie
	}

	func getTitle() -> String {
		guard let title = self.movie?.title else {
			return "No title"
		}
		return title
	}

	func getOverview() -> String {
		guard let overview = self.movie?.overview else {
			return "No overview"
		}
		return overview
	}

	func setMovie(movie: Movie) {
		self.movie = movie
	}
}

extension Movie {
	static var sampleData: [Self] {
		let firstMovie = Movie(title: "Космический джем: Новое поколение", overview: "Чтобы спасти сына, знаменитый чемпион НБА отправляется в сказочный мир, где в команде мультяшек вынужден сражаться на баскетбольной площадке с цифровыми копиями знаменитых игроков.", genres: ["мультфильм", "комедия", "семейный", "фантастика"])
		let secondMovie = Movie(title: "Дюна", overview: "Наследник знаменитого дома Атрейдесов Пол отправляется вместе с семьёй на одну из самых опасных планет во Вселенной — Арракис. Здесь нет ничего, кроме песка, палящего солнца, гигантских чудовищ и основной причины межгалактических конфликтов — невероятно ценного ресурса, который называется меланж. В результате захвата власти Пол вынужден бежать и скрываться, и это становится началом его эпического путешествия.", genres: ["фантастика", "приключения"])
		let thirdMovie = Movie(title: "Вечные", overview: "Вечные — представители расы генетически улучшенных суперлюдей, тайно живущих на Земле. Они появились на свет 5 миллионов лет назад в результате экспериментов могущественных целестиалов. Наделённые невероятными суперспособностями, на протяжении тысячелетий они скрывались от человеческой цивилизации, втайне защищая людей от монструозных девиантов. Однако, последние события и действия Таноса заставили их выйти на свет.", genres: ["фантастика", "боевик", "приключения"])
		let fourthMovie = Movie(title: "Главный герой", overview: "У сотрудника крупного банка всё идёт по накатанной, пока однажды он не выясняет, что окружающий его мир — это часть огромной видеоигры, а сам он в ней — всего лишь второстепенный персонаж. Хватит ли у него духу переписать свой код, обратить на себя внимание прекрасной девушки и, наконец, спасти мир? Одним словом, получится ли из него главный герой?", genres: ["фантастика", "боевик", "приключения","фантастика"])
		let fifthMovie = Movie(title: "Не время умирать", overview: "Джеймс Бонд оставил оперативную службу и наслаждается спокойной жизнью на Ямайке. Все меняется, когда на острове появляется его старый друг Феликс Лейтер из ЦРУ с просьбой о помощи. Миссия по спасению похищенного ученого оказывается опаснее, чем предполагалось изначально. Бонд попадает в ловушку к таинственному злодею, вооруженному опасным технологическим оружием.", genres: ["приключения", "боевик", "триллер"])
		let sixthMovie = Movie(title: "Декстер: Новая кровь", overview: "Главный тв-маньяк возвращается. Теперь Декстер Морган живет под вымышленным именем в северной части штата Нью-Йорк. Он пытается забыть свое темное прошлое, но в городе происходит ряд загадочных похищений и убийств. Эти мрачные события заставляют Декстера снова вернуться к своему невеселому ремеслу.", genres: ["драма", "криминал"])
		let seventhMovie = Movie(title: "Финч", overview: "Постапокалипсис. Инженер-робототехник Финч переживает, что никто не сможет позаботиться о его собаке после смерти. Он строит робота и отправляется в путешествие, обучая своего нового компаньона жизни, любви, дружбе и дает ему понять, что значит быть человеком.", genres: ["фантастика", "драма", "приключения"])
		let eighthMovie = Movie(title: "Веном", overview: "Что если в один прекрасный день в тебя вселяется существо-симбиот, которое наделяет тебя сверхчеловеческими способностями? Вот только Веном – симбиот совсем недобрый, и договориться с ним невозможно. Хотя нужно ли договариваться?.. Ведь в какой-то момент ты понимаешь, что быть плохим вовсе не так уж и плохо. Так даже веселее. В мире и так слишком много супергероев! Мы – Веном!", genres: ["фантастика", "боевик"])
		let ningthMovie = Movie(title: "Чёрная вдова", overview: "Наташе Романофф предстоит лицом к лицу встретиться со своим прошлым. Чёрной Вдове придется вспомнить о том, что было в её жизни задолго до присоединения к команде Мстителей, и узнать об опасном заговоре, в который оказываются втянуты её старые знакомые — Елена, Алексей (известный как Красный Страж) и Мелина.", genres: ["фантастика", "боевик", "приключения"])
		let tenthMovie = Movie(title: "Шан-Чи и легенда десяти колец", overview: "Мастеру боевых искусств Шан-Чи предстоит противостоять призракам из собственного прошлого, по мере того как его втягивают в паутину интриг таинственной организации «Десять колец».", genres: ["фэнтези", "боевик", "приключения"])

		return [firstMovie, secondMovie, thirdMovie, fourthMovie, fifthMovie, sixthMovie, seventhMovie, eighthMovie, ningthMovie, tenthMovie]
	}
}
