*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 240 171 135 145 97 202 246 221 169 25 249 235 91 141 252 91 93 100 132 201 133 52 93 254 68 195 134 94 195 199 29 135 183 150 231 146 51 14 184 23 29 202 71 55 224 230 42 103 69 49 241 202 167 135 209 114 9 219 125 133 213 2 136 5 33 3 110 21 91 240 147 254 17 122 111 227 48 160 116 147 228 55 158 138 137 184 253 62 199 226 211 196 22 109 231 90 153 69 222 95 71 47 13 96 75 125 135 180 18 104 228 118 66 25 152 192 137 156 7 20 180 39 47 42 188 75 3 162 39 81 232 139 59 136 53 210 53 46 171 171 29 129 53 123 0 195 28 107 161 137 83 203 94 98 88 180 228 157 192 228 104 252 168 97 67 24 47 62 219 33 83 42 123 146 77 189 196 193 66 228 16 32 88 244 57 248 158 213 136 38 76 54 220 9 103 114 232 196 142 119 144 66 148 220 48 71 117 39 210 129 211 48 244 246 26 225 213 25 98 91 86 187 60 217 156 179 135 170 26 242 106 141 248 93 231 107 147 66 3 173 76 28 169 159 8 47 234 132 169 38 64 92 53 46 34 56 226 160 8 71 67 160 209 79 159 234 98 150 234 204 3 201 185 36 198 248 226 149 94 202 122 162 78 91 66 3 196 27 187 119 59 19 199 215 158 190 115 233 26 119 26 171 195 62 184 85 185 66 65 88 181 72 146 118 85 81 206 152 43 86 68 51 90 178 26 238 177 114 48 68 3 116 146 13 61 239 121 184 73 189 138 188 232 222 52 115 102 152 143 40 59 179 229 47 58 58 170 120 119 233 236 227 167 57 46 0 30 238 17 13 190 129 155 114 163 14 49 124 253 195 154 62 154 150 17 251 55 178 211 158 127 15 60 152 46 116 186 82 28 112 7 78 114 210 150 176 242 128 158 184 235 91 203 34 143 162 163 2 133 252 188 169 57 208 235 210 62 180 48 149 176 36 229 186 11 202 247 105 248 122 84 53 155 223 233 142 215 35 180 230 196 16 187 56 165 185 53 207 41 108 223 33 161 46 52 234 251 87 143 136 169 102 184 178 208 2 92 87 234 186 10 167 122 178 31 46 246 41 72 160 38 139 44 194 48 200 216 78 39 224 213 242 149 39 181 141 154 45 35 11 30 134 166 139 132 75 253 222 84 151 114 76 225 148 155 224 211 77 151 227 189 255 5 99 242 54 231 29 0 212 115 229 126 15 191 249 2 250 5 254 137 48 126 61 182 39 205 229 41 77 251 116 43 42 184 142 203 65 196 68 74 252 176 32 16 3 225 170 28 105 0 4 167 241 115 75 126 185 15 203 49 52 192 17 222 0 49 32 41 82 149 245 152 117 75 184 27 56 58 107 173 79 29 133 91 156 178 109 232 72 185 160 171 194 191 178 198 100 190 198 43 251 122 220 220 192 31 78 148 130 221 167 34 242 231 30 69 131 43 240 212 201 183 44 246 115 94 135 178 163 53 225 152 7 73 183 238 224 157 203 195 51 198 219 106 32 156 16 101 145 202 29 69 13 198 51 254 229 221 122 160 205 72 228 60 175 57 198 56 72 84 50 10 169 83 12 41 73 130 251 170 133 136 204 129 227 189 167 108 170 99 44 188 226 161 6 148 208 192 70 241 91 121 251 188 140 191 95 86 125 23 10 46 62 42 93 94 199 52 165 236 87 180 55 205 16 77 6 18 9 141 165 74 254 81 211 47 3 56 114 159 131 101 135 234 180 138 19 162 176 47 20 107 158 241 179 5 211 38 216 13 26 85 53 130 56 20 130 239 121 190 74 152 132 12 122 77 32 13 135 13 117 9 154 156 242 81 135 129 230 118 143 132 105 30 221 56 22 3 107 88 72 77 115 55 90 246 182 56 37 95 157 156 182 69 127 190 81 118 126 174 238 241 214 133 45 61 237 95 142 41 100 67 225 226 233 222 146 195 105 162 221 12 130 69 58 164 1 157 137 229 218 185 32 86 196 73 75 130 219 214 240 31 71 99 115 71 188 207 2 7 213 171 18 89 138 27 204 233 187 184 239 12 210 155 216 246 221 84 217 84 135 160 53 172 193 86 249 128 107 115 72 153 125 158 75 91 17 8 137 251 8 155 64 77 78 125 80 26 67 138 160 22 89 212 103 58 154 107 117 20 50 62 163 154 201 84 64 250 108 98 10 59 229 158 159 80 89 231 219 189 40 155 132 132 206 16 65 123 95 199 248 208 46 109 243 160 219 54 193 1283367517
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
