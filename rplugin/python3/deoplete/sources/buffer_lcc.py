from .base import Base
from deoplete.util import parse_buffer_pattern
import re


class Source(Base):

    def __init__(self, vim):
        Base.__init__(self, vim)

        self.name = 'buffer_lcc'
        self.mark = '[LCC]'

    def gather_candidates(self, context):
        candidates = []
        pattern = re.compile('([A-Z][a-z]+)')
        keywords = parse_buffer_pattern(
            self.vim.current.buffer,
            context['keyword_patterns'])
        for keyword in keywords:
            matches = re.findall(pattern, keyword)
            if len(matches) > 0:
                candidates.append(
                    {'word' : matches[0].lower() + ''.join(matches[1:])})
        return candidates
