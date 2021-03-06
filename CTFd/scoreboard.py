from flask import Blueprint, render_template

from CTFd.cache import cache, make_cache_key
from CTFd.models import Users
from CTFd.utils import config
from CTFd.utils.decorators.visibility import check_score_visibility
from CTFd.utils.scores import get_standings
from CTFd.utils.user import get_badges

scoreboard = Blueprint("scoreboard", __name__)


@scoreboard.route("/scoreboard")
@check_score_visibility
@cache.cached(timeout=60, key_prefix=make_cache_key)
def listing():
    standings = get_standings()
    return render_template(
        "scoreboard.html",
        standings=standings,
        score_frozen=config.is_scoreboard_frozen(),
        badges=get_badges(standings),
    )
